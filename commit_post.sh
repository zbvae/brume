#!/bin/bash
#author: billy
#desc: commit post articles

MSG=$1

if [ "" == "$MSG" ]
then
    MSG="发布新文章"
fi

# add dir
git add .

# commit to local
git commit -m "$MSG"

# push to github
git push origin master