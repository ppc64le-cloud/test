#!/bin/bash
set -u

echo "Prow Job to run CI tests on the Docker packages"

${PWD}/dockerctl.sh start

set -o allexport
export PATH_CI="${PWD}/upstream-master-ci"
# Get the env files
echo "** Set up (env files) **"
chmod ug+x ${PATH_CI}/get-env-ci.sh && ${PATH_CI}/get-env-ci.sh

echo "*** Build dev image ***"
chmod ug+x ${PATH_CI}/build-dev-image.sh && ${PATH_CI}/build-dev-image.sh

echo "*** Run integration tests ***"
chmod ug+x ${PATH_CI}/integration-tests.sh && ${PATH_CI}/integration-tests.sh