#!/bin/bash
# Thanks to https://aguo.us/writings/g2p-conversion.html !
. ../../../tools/env.sh
echo $@ | g2p.py --model g2p.model --apply - 2>/dev/null
