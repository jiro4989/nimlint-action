# GitHub Action: Lint Nim with reviewdog

nimlint-action is inspired by [reviewdog/action-eslint](https://github.com/reviewdog/action-eslint).

[![Docker Image CI](https://github.com/reviewdog/action-eslint/workflows/Docker%20Image%20CI/badge.svg)](https://github.com/reviewdog/action-eslint/actions)
[![Release](https://img.shields.io/github/release/reviewdog/action-eslint.svg?maxAge=43200)](https://github.com/reviewdog/action-eslint/releases)

This action runs `nim check` with
[reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve
code review experience.

[![github-pr-check sample](https://user-images.githubusercontent.com/3797062/65439130-a6043b80-de61-11e9-98b5-bd9567e184b0.png)](https://github.com/reviewdog/action-eslint/pull/1)
[![github-pr-review sample](https://user-images.githubusercontent.com/3797062/65439073-91c03e80-de61-11e9-9077-39d480fbad0d.png)](https://github.com/reviewdog/action-eslint/pull/1)

## Inputs

### `github_token`

**Required**. Must be in form of `github_token: ${{ secrets.github_token }}`'.

### `level`

Optional. Report level for reviewdog [info,warning,error].
It's same as `-level` flag of reviewdog.

### `reporter`

Reporter of reviewdog command [github-pr-check,github-check,github-pr-review].
Default is github-pr-check.
It's same as `-reporter` flag of reviewdog.

github-pr-review can use Markdown and add a link to rule page in reviewdog reports.

### `eslint_flags`

Optional. Flags and args of eslint command. Default: '.'

## Example usage

You also need to install [eslint](https://github.com/eslint/eslint).

```shell
# Example
$ npm install eslint -D
```

You can create [eslint
config](https://eslint.org/docs/user-guide/configuring)
and this action uses that config too.

### [.github/workflows/nimlint-action.yml](.github/workflows/nimlint-action.yml)

```yml
name: nimlint
on: [pull_request]
jobs:
  nimlint:
    name: runner / nimlint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: nimlint
        uses: jiro4989/nimlint-action@v1
        with:
          github_token: ${{ secrets.github_token }}
          reporter: github-pr-review # Change reporter.
          src: 'src/*.nim'
```
