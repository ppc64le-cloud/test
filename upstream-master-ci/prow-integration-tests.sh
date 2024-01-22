#!/bin/bash
set -u

# Path to the scripts
PATH_SCRIPTS="/home/prow/go/src/github.com/${REPO_OWNER}/${REPO_NAME}"
PATH_CI="${PATH_SCRIPTS}/upstream-master-ci"
export PATH_CI
export PATH_SCRIPTS

echo "Prow Job to run CI tests on the Docker packages"

# Go to the workdir
cd /workspace
echo "* Starting dockerd and waiting for it *"
${PATH_SCRIPTS}/dockerctl.sh start

set -o allexport

# Get the env files
echo "** Set up (env files) **"
chmod ug+x ${PATH_CI}/get-env-ci.sh && ${PATH_CI}/get-env-ci.sh

echo "*** Build dev image ***"
chmod ug+x ${PATH_CI}/build-dev-image.sh && ${PATH_CI}/build-dev-image.sh

echo "*** Run integration tests ***"
chmod ug+x ${PATH_CI}/integration-tests.sh && ${PATH_CI}/integration-tests.sh