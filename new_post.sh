#!/bin/bash
#author: billy
#desc: create a new post articles with template

TITLE=$1
TAG=$2
TEMPLATE=draft_template.md
DATE=`date "+%Y-%m-%d"`
TIME=`date "+%H:%M:%S"`
# echo $DATE $TIME

DIR=`pwd`

# file path generate
FILE_NAME="$DATE-`echo $TITLE|sed 's/[ ][ ]*/-/g'`.md"
echo "file name:" _posts/$FILE_NAME

# template content
CONTENT=`cat $TEMPLATE`

# fill title
POST_TITLE=$TITLE

# fill title
CONTENT=`echo "${CONTENT}" | sed "s/title:/title: ${POST_TITLE}/g"`

# fill time
CONTENT=`echo "${CONTENT}" | sed "s/time:/time: ${DATE} ${TIME}/g"`

# fill tag
CONTENT=`echo "${CONTENT}" | sed "s/tags:/tags: \[${TAG}\]/g"`

# output file (check exists)
if [ ! -e "$DIR/_posts/$FILE_NAME" ]; then
    echo "${CONTENT}" > _posts/$FILE_NAME
else
    echo "file exists..."
fi

# edit file with vim
# vim _posts/$FILE_NAME
# edit file with typora
typora _posts/$FILE_NAME
