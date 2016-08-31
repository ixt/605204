#!/bin/bash

## Test Script

#entry=$1

while read entry; do
    sumy luhn --url="http://simple.wikipedia.org/wiki/$entry" > .tempin
    ./CountSyllables.py -i .tempin -o .tempout > outputs/$entry.txt
    cat outputs/$entry.txt
done < list.txt
rm .tempin .tempout

echo "DONE!"
