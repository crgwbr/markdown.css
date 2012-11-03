#!/bin/bash

IN_EXT="md"
OUT_EXT="html"
TEMP="/tmp/export-pages/"
BRANCH="gh-pages"

rm -rf "$TEMP"
mkdir -p "$TEMP"

git stash save "Building Pages"

for file in "*.$IN_EXT"
do
    name=`basename "$file" ".$IN_EXT"`
    echo "Exporting $name.$IN_EXT to $name.$OUT_EXT"
    markdown_py -o html5 -e utf8 -f "$TEMP/$name.$OUT_EXT" "$file"
done

git checkout -b "$BRANCH"
rm -rf *
cp "$TEMP/*" ./
git add --all
git commit -m "Automated page build by `whoami`"
git push origin "$BRANCH"
git push github "$BRANCH"
git checkout master
git stash pop

rm -rf "$TEMP"