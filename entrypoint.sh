#!/bin/sh

cd "$GITHUB_WORKSPACE"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

nim --version

for f in $INPUT_SRC; do
  nim check "$f" 2>&1 > /dev/null |
    grep -E "^([^)]+)\) (Hint|Warning|Error): .*" |
    sed \
      -e "s/(/:/" \
      -e "s/, /:/" \
      -e "s/) /:/"
done |
  tee check.log

cat check.log | reviewdog -efm="%f:%l:%c:%m" -name="nimlint" -reporter="${INPUT_REPORTER:-github-pr-check}" -level="${INPUT_LEVEL}"
