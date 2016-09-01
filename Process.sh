#!/bin/bash

## Test Script

#entry=$1

while read entry; do
   # lynx --dump http://simple.wikipedia.org/wiki/$entry | sed 's/\[[0-9]*\]//g' > .tempin
    #NAVIGATIONLINE=$(grep -n "References" .tempin | cut -d ':' -f1 | tail -1)
    #echo $NAVIGATIONLINE
    #cat .tempin | head -n$NAVIGATIONLINE > .tempin
    wget -O .tempsite "http://simple.wikipedia.org/wiki/$entry" -q
    cat .tempsite | sed 's/<[a-z]*>//g' | sumy luhn > .tempin
    ./CountSyllables.py -i .tempin -o .tempout > outputs/$entry.txt
    cat outputs/$entry.txt
done < list.txt
rm .tempin .tempout

echo "DONE!"
