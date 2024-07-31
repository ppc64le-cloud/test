pushd moby

# Store logs by commit id to avoid overwriting
export COMMIT=$(git rev-parse --short HEAD)

checkDirectory() {
  if ! test -d $1
  then
    echo "Could not create $1, exiting."
    mkdir $1
    if [[ $? -ne 0 ]]; then
      exit 1
    fi
    echo "$1 created"
  else
    echo "$1 already created"
  fi
}

DIR_LOGS_COS="/mnt/s3_ppc64le-docker/prow-docker/ppc64le-ci/${COMMIT}"
checkDirectory ${DIR_LOGS_COS}

rm -f ${DIR_LOGS_COS}/unit.log && touch ${DIR_LOGS_COS}/unit.log
make -o build test-unit 2>&1 | tee -a ${DIR_LOGS_COS}/unit.log
cp bundles/junit-report.xml ${ARTIFACTS}
grep "failure" ${DIR_LOGS_COS}/unit.log > /dev/null 2>&1
if [[ $? == 1 ]]; then
  popd
  exit 0
fi

popd
exit 1