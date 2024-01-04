source ci/env.list
apt-get -y update && apt-get -y upgrade && apt-get -y install sudo iptables wget

# Install Go
wget https://golang.org/dl/go1.21.5.linux-ppc64le.tar.gz
tar -C /usr/local -xzf go1.21.5.linux-ppc64le.tar.gz
export PATH=/usr/local/go/bin:$PATH

mkdir makebundles && cd makebundles
git clone https://github.com/moby/moby.git
pushd moby
make binary dynbinary build run shell
docker run --rm -t --privileged \
                                  -v "$WORKSPACE/bundles:/go/src/github.com/docker/docker/bundles" \
                                  --name dockerbuildimage \
                                  -e DOCKER_EXPERIMENTAL \
                                  -e DOCKER_GITCOMMIT=${GIT_COMMIT} \
                                  -e DOCKER_GRAPHDRIVER \
                                  -e VALIDATE_REPO=${GIT_URL} \
                                  dockerbuildimage \
                                  hack/test/unit
popd
docker run --rm -t --privileged \
                                  -v "$WORKSPACE/bundles:/go/src/github.com/docker/docker/bundles" \
                                  --name dockerbuildimage \
                                  -e DOCKER_EXPERIMENTAL \
                                  -e DOCKER_GITCOMMIT=${GIT_COMMIT} \
                                  -e DOCKER_GRAPHDRIVER \
                                  -e TESTDEBUG \
                                  -e TEST_INTEGRATION_USE_SNAPSHOTTER \
                                  -e TEST_SKIP_INTEGRATION_CLI \
                                  -e TIMEOUT \
                                  -e VALIDATE_REPO=${GIT_URL} \
                                  dockerbuildimage \
                                  hack/make.sh \
                                    dynbinary \
                                    test-integration