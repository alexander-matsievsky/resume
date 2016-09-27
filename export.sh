#!/usr/bin/env bash

set -ex

./node_modules/.bin/resume export resume.html --theme=elegant

cp resume.json resume.copy.json
node format-dates.js

./node_modules/.bin/resume export resume.pdf --theme=paper
./node_modules/.bin/resume export /tmp/README.html --theme=flat
pandoc -f html -t markdown_github -i /tmp/README.html >/tmp/README.md
url="https://cdn.rawgit.com/alexander-matsievsky/resume/$(git show-ref -s HEAD)"
cat <(echo "[[HTML version]]($url/resume.html)")  \
<(echo "[[PDF version]]($url/resume.pdf)")  \
<(echo '')  \
/tmp/README.md >README.md

mv resume.copy.json resume.json
