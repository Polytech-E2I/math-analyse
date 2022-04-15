#!/bin/bash

for dir in ./Exam*; do
    cd $dir
    pandoc --filter pandoc-crossref --toc *.md -o out.pdf
    cd ..
done
