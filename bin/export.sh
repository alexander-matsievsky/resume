#!/usr/bin/env bash

set -ex

npx resume export --resume=assets/resume.json --theme=elegant assets/resume.html
npx resume export --resume=assets/resume.json --theme=even /tmp/README.html
npx resume export --resume=assets/resume.json --theme=paper assets/resume.pdf

cat - <(pandoc --to=markdown_strict /tmp/README.html) << "EOF" > README.md
[[HTML version]](https://raw.githack.com/alexander-matsievsky/resume/master/assets/resume.html)
[[PDF version]](https://raw.githack.com/alexander-matsievsky/resume/master/assets/resume.pdf)
EOF
