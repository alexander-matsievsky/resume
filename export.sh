#!/usr/bin/env bash

set -ex

./node_modules/.bin/resume export resume.html --theme=elegant

cp resume.json resume.copy.json
node format-dates.js
./node_modules/.bin/resume export resume.pdf --theme=paper
./node_modules/.bin/resume export /tmp/README.html --theme=flat
mv resume.copy.json resume.json

cat - <(pandoc -f html -t markdown_github -i /tmp/README.html) <<EOF >README.md
[[HTML version]](./resume.html)
[[PDF version]](./resume.pdf)

EOF
