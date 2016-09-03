#!/bin/bash

## Test Script -- not clean, will probably never be clean
## if you ever attempt to clean this that would be nice but totally not required as functionality is limited anyway

SOURCE='https://simple.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&redirects=1&titles='

sed 1d list.txt | while read entry; do
    #lynx --dump -width 1024 http://simple.wikipedia.org/wiki/$entry | sed 's/\[[^[]*\]//g' > .tempsite
    lynx --dump -width 1024 $SOURCE$entry > .tempsite
    cat .tempsite | sed -e 's/.*"extract":"//' | sed -e 's/<[^<>]*>//g' | sed -e 's/([^()]*)//g' > .tempwhile

    cat .tempwhile | uni2ascii -a U -q | sed -e 's/\\n/\n/g' | sed -e 's/\\u[0-9a-f][0-9a-f][0-9a-f][0-9a-f]//g' \
        | sed -e 's/\\//g' | sed -e 's/[[:punct:]]//g'  > .tempin

    ./Haiku.py -i .tempin -o .tempout > outputs/$entry.txt
    echo $NAVIGATION $TITLE $entry
    cat outputs/$entry.txt
done
#rm .tempin .tempout 

echo "DONE!"
