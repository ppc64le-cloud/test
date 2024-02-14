pushd moby
mkdir tmp
touch tmp/out.txt
make -o build test-unit 2>&1 | tee tmp/out.txt
rc=$(grep "failure" tmp/out.txt | awk '{print $6;}')
cp bundles/junit-report.xml ${ARTIFACTS}
popd

if [[ $rc == 0 ]]; then
  exit 0
fi
exit 1