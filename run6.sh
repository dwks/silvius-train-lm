#!/bin/bash
. cmd.sh
. path.sh

corpus=corpus.txt
. utils/parse_options.sh  # accept options

## make basic data/local/dict1 (words.txt, etc) from cantab
#echo "=== Generating basic dictionary"
local/download_data.sh
local/prepare_dict.sh || exit 1

# prepare our word disambiguation symbols
mkdir -p data/local/dict1
echo '#english' > data/local/dict1/silvius_wdisambig.txt
#echo '#command' >> data/local/dict1/silvius_wdisambig.txt
local/prepare_lang_nocheck.sh \
    --extra-word-disambig-syms data/local/dict1/silvius_wdisambig.txt \
    data/local/dict1 "<unk>" data/local/lang1 data/dict1

# replace #english with arc to english LM
dest=data/lang_6
export dest
export corpus
cp -ar data/dict1 $dest
echo "=== Generating english LM"
local/make_english_lm.sh
echo "=== Generating command+merged LM"
local/make_command_lm.sh


# convert G.fst -> HCLG.fst
tri=exp/tri_6a
rm -rf $tri
mkdir -p $tri
echo "=== Building HCLG.fst from final.mdl and tree"
cp -ar archive/exp/nnet2_online/nnet_ms_sp_online/* $tri/
utils/mkgraph.sh data/lang_6 $tri $tri/graph || exit 1

exit
