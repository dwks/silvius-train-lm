This project trains new dual command/English language models, intended to be
used for voice coding with Silvius. It relies on Kaldi. Clone this repository
inside kaldi/egs/tedlium, edit corpus.txt and corpus.dict as appropriate, then
execute run6.sh. This script should take 15 minutes. The output is in
exp/tri_6a and may be imported into silvius-backend.

To generate word pronunciations, try ./pronounce.sh foobar.
