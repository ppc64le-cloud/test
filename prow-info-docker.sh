#!/bin/bash
set -u

# Path to the scripts
PATH_SCRIPTS="/home/prow/go/src/github.com/${REPO_OWNER}/${REPO_NAME}"
export PATH_SCRIPTS

echo "Prow Job to run CI tests on the Docker packages"

# Go to the workdir
cd /workspace
echo "* Starting dockerd and waiting for it *"
${PATH_SCRIPTS}/dockerctl.sh start

# Get the env files
echo "** Set up (env files) **"
chmod ug+x ${PATH_SCRIPTS}/get-env-ci.sh && ${PATH_SCRIPTS}/get-env-ci.sh

set -o allexport
source "ci/env.list"

echo "*** Check Config ***"
chmod ug+x ${PATH_SCRIPTS}/info.sh && ${PATH_SCRIPTS}/info.sh