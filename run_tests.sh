#!/usr/bin/env bash

while getopts "I:S:B:C:" flag
do
    case "${flag}" in
        B) INPUT_BROWSER=${OPTARG};;
        C) INPUT_CLIENT=${OPTARG};;
        S) INPUT_SRC=${OPTARG};;
        I) INSTALL_PACKAGES=${OPTARG};;
        *) echo "${OPTARG} is an invalid parameter";;
    esac
done

SRC=${INPUT_SRC:=""}
BROWSER=${INPUT_BROWSER:=""}
CLIENT=${INPUT_CLIENT:=""}
INSTALL_PACKAGES=true
RUN_COMMAND="cd /app/$SRC"

if [ "$INSTALL_PACKAGES" = true ] ; then
    UPDATE_PACKAGE_MANAGER_CMD="python3.11 -m pip install --upgrade pip"
    INSTALLATION_PACKAGES_CMD="pip3.11 install -r requirements.txt"
    RUN_COMMAND="${RUN_COMMAND}; ${UPDATE_PACKAGE_MANAGER_CMD}; ${INSTALLATION_PACKAGES_CMD}"
fi

RUN_COMMAND="${RUN_COMMAND}; robot -d results Tests/${BROWSER}/${CLIENT}"

# exit when any command fails
set -e

docker run -i --name automation_tests --rm \
  -v $(pwd):/app/automation \
  -v $(pwd)/ci-cache/py/3.11/cache:/cache/pip \
  clickoneagencia/automation \
  /bin/sh -c "$RUN_COMMAND"
