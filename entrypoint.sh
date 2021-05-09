#! /usr/bin/env bash

bashAction() {
  local commandString="$1"
  local failOnError="$2"
  local stdout stderr output
  local -i exitcode
  runCommand "$@"
  setVariables
  actionExit
}

runCommand() {
  local stderrTemporaryFilePath="$( mktemp )"
  stdout="$( eval "$commandString" 2>"$stderrTemporaryFilePath" )"
  exitcode=$?
  stderr="$(<"$stderrTemporaryFilePath")"
  rm -f "$stderrTemporaryFilePath"
  local newline=$'\n'
  output="${stdout}${newline}${stderr}"
}

setVariables() {
  echo "::set-output name=stdout::$stdout"
  echo "::set-output name=stderr::$stderr"
  echo "::set-output name=output::$output"
  echo "::set-output name=exitcode::$exitcode"
  if (( exitcode == 0 ))
  then
    echo "::set-output name=passed::true"
    echo "::set-output name=failed::false"
  else
    echo "::set-output name=passed::false"
    echo "::set-output name=failed::true"
  fi
}

actionExit() {
  if [ "$failOnError" = true ]
  then
    return $exitcode
  else
    return 0
  fi
}

bashAction "$@"
