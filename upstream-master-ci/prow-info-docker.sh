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

echo "*** Check Config ***"
chmod ug+x ${PATH_CI}/info.sh && ${PATH_CI}/info.sh