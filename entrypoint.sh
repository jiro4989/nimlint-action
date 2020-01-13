#!/bin/sh

cd "$GITHUB_WORKSPACE"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

nim --version

nim check $INPUT_SRC 2>&1 > /dev/null |
  grep -E "^([^)]+)\) (Hint|Warning|Error): .*\[[^]]+\]$" |
  sed \
    -e "s/(/:/" \
    -e "s/, /:/" \
    -e "s/) /:/"

nim check $INPUT_SRC 2>&1 > /dev/null |
  grep -E "^([^)]+)\) (Hint|Warning|Error): .*\[[^]]+\]$" |
  sed \
    -e "s/(/:/" \
    -e "s/, /:/" \
    -e "s/) /:/" |
  reviewdog -efm="%f:%l:%c:%m" -name="nimlint" -reporter="${INPUT_REPORTER:-github-pr-check}"

# if [ "${INPUT_REPORTER}" == 'github-pr-review' ]; then
#   # Use github-pr-review reporter to format result to include link to rule page.
#   nim check $INPUT_SRC 2>&1 > /dev/null |
#     grep -E "^([^)]+)\) (Hint|Warning|Error): .*\[[^]]+\]$" |
#     reviewdog -efm="%f(%l, %c) %m" -name="nimlint" -reporter=github-pr-review -level="${INPUT_LEVEL}"
# else
#   :
#   # # github-pr-check,github-check (GitHub Check API) doesn't support markdown annotation.
#   # $(npm bin)/eslint -f="stylish" ${INPUT_ESLINT_FLAGS:-'.'} |
#   #   reviewdog -efm="%f(%l, %c) %m" -name="nimlint" -reporter="${INPUT_REPORTER:-github-pr-check}" -level="${INPUT_LEVEL}"
# fi
