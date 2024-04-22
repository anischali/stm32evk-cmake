#! /usr/bin/env bash

pid="$(ps -aux | grep vscode | grep -v bash | awk '{ print $2}')"
project_dir="${1}"

if [ -e ".exported" ] || [ ! -e "${project_dir}/.env" ]; then
    rm .exported
    exit 0
fi

touch .exported

declare -x -g $(cat < ${project_dir}/.env)

${SHELL} -c "code -n ${project_dir} && kill -9 $pid"