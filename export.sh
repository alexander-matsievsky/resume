#!/usr/bin/env bash

set -ex

./node_modules/.bin/resume export resume.html --theme=elegant

cp resume.json resume.copy.json
node format-dates.js
./node_modules/.bin/resume export resume.pdf --theme=paper
./node_modules/.bin/resume export /tmp/README.html --theme=flat
mv resume.copy.json resume.json

ref="$(git show-ref -s HEAD)"
cat - <(pandoc -f html -t markdown_github -i /tmp/README.html) <<EOF >README.md
[[HTML version]](https://cdn.rawgit.com/alexander-matsievsky/resume/${ref}/resume.html)
[[PDF version]](https://cdn.rawgit.com/alexander-matsievsky/resume/${ref}/resume.pdf)

EOF
