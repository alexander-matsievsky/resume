#!/usr/bin/env bash

set -ex

npx resume export --resume=assets/resume.json --theme=elegant assets/resume.html
npx resume export --resume=assets/resume.json --theme=even /tmp/README.html
npx resume export --resume=assets/resume.json --theme=paper assets/resume.pdf

cat - <(
  node -p 'new require("turndown")().turndown(fs.readFileSync(0).toString())' </tmp/README.html | tail -n+2
) <<EOF >README.md
[[HTML version]](https://raw.githack.com/alexander-matsievsky/resume/master/assets/resume.html)
[[PDF version]](https://raw.githack.com/alexander-matsievsky/resume/master/assets/resume.pdf)
EOF
