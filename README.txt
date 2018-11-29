This project trains new dual command/English language models, intended to be
used for voice coding with Silvius. It relies on Kaldi. Usage:

1. Clone kaldi (we tested git version 69cd717 but any should work). Run make
   in tools/, then configure and make in src.

2. Clone this repository as a subdirectory inside kaldi/egs/tedlium.

3. Put your command words into corpus.txt, separated by whitespace, as in the
   output of `python grammar/lm.py 1 | sort -u` from silvius frontend. You
   may wish to add the following words as commands:
   <unk> [BREATH] [COUGH] [NOISE] [SMACK] [UH] [UM]

4. Execute run6.sh. This script should take 15 minutes, once the pretrained
   models and data are downloaded (1.5GB).

5. If you have any non-English words, the run6.sh script will point them out
   and exit. Write their pronunciations in phones in corpus.dict. To generate
   word pronunciations automatically, try ./pronounce.sh foobar.

6. The output is in exp/tri_6a and may be imported into silvius-backend with
   silvius-backend/models/import.sh. Models will be about 70MB.

Please join the silvius mailing list if you have any questions!
https://groups.google.com/forum/#!forum/silvius
