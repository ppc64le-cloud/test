pushd ${PWD}/moby
docker buildx build --load --force-rm -t "dockerbuildimage" .
popd
exit 0