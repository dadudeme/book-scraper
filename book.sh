#!/run/current-system/sw/bin/bash
site=$(awk '/^https?:\/\/([^\/]+)/)'<<< $1)
if [ site = "www.royalroad.com" ]
then
    exec ./royalroad.sh $1
elif [ site = "www.scribblehub.com" ]
then
    exec ./scribblehub.py
