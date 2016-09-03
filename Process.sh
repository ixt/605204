#!/bin/bash

## Test Script

sed 1d list.txt | while read entry; do
    lynx --dump -width 1024 http://simple.wikipedia.org/wiki/$entry | sed 's/\[[^[]*\]//g' > .tempsite
    cat .tempsite > .tempwhile
    TITLE=$(grep -n "$(echo $entry | sed 's/_/ /g')" .tempsite | cut -d ':' -f1 | head -n2 | tail -1)
    if [[ $TITLE ]]; then
        cat .tempsite | tail -n+$TITLE > .tempwhile
    fi
    cat .tempwhile | sed -e 's/([^()]*)//g' | sed 's/\[change |//g' | sed 's/\.[a-z]*//g' | sed -e 's/[[:punct:]]//g' > .tempin

    ./Haiku.py -i .tempin -o .tempout > outputs/$entry.txt
    echo $NAVIGATION $TITLE $entry
    cat outputs/$entry.txt
done
#rm .tempin .tempout 

echo "DONE!"
