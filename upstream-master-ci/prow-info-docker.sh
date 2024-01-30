#!/bin/bash
set -u

# Path to the scripts
PATH_CI="${PWD}/upstream-master-ci"
export PATH_CI

echo "Prow Job to run CI tests on the Docker packages"

${PWD}/dockerctl.sh start

echo "*** Check Config ***"
chmod ug+x ${PATH_CI}/info.sh && ${PATH_CI}/info.sh