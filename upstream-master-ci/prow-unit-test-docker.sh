#!/bin/bash
set -u

# Path to the scripts
PATH_CI="${PWD}/upstream-master-ci"
export PATH_CI
echo "Prow Job to run CI tests on the Docker packages"

# Go to the workdir
echo "* Starting dockerd and waiting for it *"
${PWD}/dockerctl.sh start

set -o allexport

# Get the env files
echo "** Set up (env files) **"
chmod ug+x ${PATH_CI}/get-env-ci.sh && ${PATH_CI}/get-env-ci.sh

echo "*** Build dev image ***"
chmod ug+x ${PATH_CI}/build-dev-image.sh && ${PATH_CI}/build-dev-image.sh

echo "*** Run unit tests ***"
chmod ug+x ${PATH_CI}/unit-tests.sh && ${PATH_CI}/unit-tests.sh