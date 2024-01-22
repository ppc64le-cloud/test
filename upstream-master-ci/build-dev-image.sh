pushd /workspace/moby
docker buildx build --load --force-rm -t "dockerbuildimage" .
popd