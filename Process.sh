#!/bin/bash

## Test Script

#entry=$1

while read entry; do
    lynx --dump http://simple.wikipedia.org/wiki/$entry | tail -n+13 | sed 's/\[[0-9]*\]//g' > .tempin
    ./CountSyllables.py -i .tempin -o .tempout > outputs/$entry.txt
    cat outputs/$entry.txt
done < list.txt
rm .tempin .tempout

echo "DONE!"
