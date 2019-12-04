#!/bin/bash -v
pandoc -s --section-divs index.md --template mindoc-pandoc.html > index.html
mkdir _build
rsync -a css _build/
rsync -a js _build/
cp index.html _build
