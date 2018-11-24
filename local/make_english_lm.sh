#!/bin/bash 
#
# Copyright  2014 Nickolay V. Shmyrev 
# Apache 2.0


if [ -f path.sh ]; then . path.sh; fi

english_arpa_lm=db/cantab-TEDLIUM/cantab-TEDLIUM-pruned.lm3.gz
[ ! -f $english_arpa_lm ] && echo No such file $english_arpa_lm && exit 1;

source=data/dict1/.
dest=data/lang_6

rm -rf $dest
cp -r $source $dest

echo "Converting $english_arpa_lm -> $dest/G_english.fst"
gunzip -c "$english_arpa_lm" | \
    arpa2fst --disambig-symbol=#0 \
        --read-symbol-table=$dest/words.txt - $dest/G_english.fst

#cp /tmp/aaa.fst $dest/G_english.fst

#echo "Checking how stochastic G_english is (the first of these numbers should be small):"
#fstisstochastic $dest/G_english.fst

exit 0;
