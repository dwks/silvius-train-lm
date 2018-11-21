#!/bin/bash

ngram-count -lm db/command.lm -text $corpus -order 1
cat db/command.lm | arpa2fst --disambig-symbol=#0 \
    --read-symbol-table=$dest/words.txt - $dest/G_1.fst
hash_english=$(grep '^\#english' data/dict1/words.txt | awk '{ print $2 }')
#hash_command=$(grep '^\#command' data/dict1/words.txt | awk '{ print $2 }')
# replace 148338=yankee, 149935=zulu with #english, #command


echo "0 88888888 $hash_english $hash_english 4.2484951\n88888888 4\n" > $dest/extra_edges.txt

fstprint $dest/G_1.fst | \
    cat - $dest/extra_edges.txt | tee $dest/G-dump.txt | \
    fstcompile - > $dest/G_2.fst 

fstreplace $dest/G_2.fst 999999999 $dest/G_english.fst $hash_english | \
    fstarcsort --sort_type=ilabel > $dest/G.fst
