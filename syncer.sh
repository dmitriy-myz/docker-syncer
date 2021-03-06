#!/bin/bash

#EXCLUDE='.git'
#REVERSE="node_modules|var|vendor"
#OWNER="www-data:www-data"
cd $(dirname $0)

REVERSE="$(echo "$REVERSE" | tr '|' '\n')"

EXCLUDEFILE="/excludes.list"
# Prepare
echo -n > "$EXCLUDEFILE"
cp lsyncd.conf /lsyncd.conf

echo "$EXCLUDE" | tr '|' '\n'  | sed 's#^#/#g' >> "$EXCLUDEFILE"

IFS=$'\n'
for f in $REVERSE; do
    echo "/$f" >> "$EXCLUDEFILE"
    cat lsyncd-template | sed "s/##FILENAME##/$f/g" >> /lsyncd.conf
    if [ ! -e /target/$f ]; then
        rsync -av --chown "$OWNER" "/source/$f" /target/
    fi 
done
cat -n /lsyncd.conf

exec lsyncd /lsyncd.conf



