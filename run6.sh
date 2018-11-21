#!/bin/bash
. cmd.sh
. path.sh

corpus=corpus.txt
. utils/parse_options.sh  # accept options

# make basic data/local/dict1 (words.txt, etc) from cantab
echo "=== Generating basic dictionary"
local/download_data.sh
local/prepare_dict.sh

# prepare our word disambiguation symbols
mkdir -p data/local
echo '#english' > data/local/dict1/silvius_wdisambig.txt
#echo '#command' >> data/local/dict1/silvius_wdisambig.txt
utils/prepare_lang.sh \
    --extra-word-disambig-syms data/local/dict1/silvius_wdisambig.txt \
    data/local/dict1 "<unk>" data/local/lang1 data/dict1

# replace #english with arc to english LM
dest=data/lang_6
cp -ar data/dict1 $dest
echo "=== Generating english LM"
local/make_english_lm.sh
echo "=== Generating command+merged LM"
local/make_command_lm.sh


# convert G.fst -> HCLG.fst
echo "=== Building HCLG.fst and tree"
utils/mkgraph.sh data/lang_6 exp/tri_6a exp/tri_6a/graph || exit 1

exit
