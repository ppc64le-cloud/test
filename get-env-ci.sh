set -eu
FILE_ENV_PATH="${PATH_SCRIPTS}/ci"
FILE_ENV="env.list"
mkdir -p /workspace/ci
cp ${FILE_ENV_PATH}/${FILE_ENV} /workspace/ci/${FILE_ENV}
set -o allexport
source /workspace/ci/${FILE_ENV}

if [[ ! -f /workspace/ci/${FILE_ENV} ]]; then
    echo "The env.list has not been generated."
    exit 1
else

# Check there is CHECK_CONFIG_COMMIT and GIT_COMMIT in env.list from github
    if grep -Fq "CHECK_CONFIG_COMMIT" ci/${FILE_ENV} && grep -Fq "GIT_COMMIT" ci/${FILE_ENV}
    then
        echo "CHECK_CONFIG_COMMIT : ${CHECK_CONFIG_COMMIT} and GIT_COMMIT :${GIT_COMMIT} are in env.list."
    else
        echo "CHECK_CONFIG_COMMIT and/or GIT_COMMIT are not in env.list."
        cat /workspace/ci/${FILE_ENV}
        exit 1
    fi
    echo "The env.list has been copied and the list of distributions has been generated and added to env.list."
fi