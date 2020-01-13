#!/usr/bin/env bash

set -ex

node format-dates.js
sed -i \
  -e's/{{endDate}}/{{_endDateFormatted}}/g' \
  -e's/{{startDate}}/{{_startDateFormatted}}/g' \
  ./node_modules/jsonresume-theme-flat/resume.template \
  ./node_modules/jsonresume-theme-paper/resume.template

npx resume export --theme=elegant resume.html
npx resume export --theme=flat /tmp/README.html
npx resume export --theme=paper resume.pdf

cat - <(pandoc --from=html --to=gfm /tmp/README.html) <<EOF >README.md
[[HTML version]](./resume.html)
[[PDF version]](./resume.pdf)

EOF
