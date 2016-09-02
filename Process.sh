#!/bin/bash

## Test Script

sed 1d list.txt | while read entry; do
    lynx --dump -width 1024 http://simple.wikipedia.org/wiki/$entry | sed 's/\[[^[]*\]//g' > .tempsite
    cat .tempsite > .tempwhile
    NAVIGATION=$((( 1 + $(grep -n "Navigation menu" .tempsite | cut -d ':' -f1 | tail -1))))
    TITLE=$(grep -n "$(echo $entry | sed 's/_/ /g')" .tempsite | cut -d ':' -f1 | head -n2 | tail -1)
    echo $NAVIGATION $entry
    cat .tempsite | tail -n+$TITLE | head --lines=$NAVIGATION > .tempwhile
    
    cat .tempwhile | sed -e 's/([^()]*)//' | sed 's/\[change |//g' > .tempin

    ./Haiku.py -i .tempin -o .tempout > outputs/$entry.txt
    cat outputs/$entry.txt
done
#rm .tempin .tempout 

echo "DONE!"
