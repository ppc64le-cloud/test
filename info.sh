source ci/env.list
docker version
docker info
echo "check-config.sh version: ${CHECK_CONFIG_COMMIT}"
curl -fsSL -o ${PATH_SCRIPTS}/check-config.sh "https://raw.githubusercontent.com/moby/moby/${CHECK_CONFIG_COMMIT}/contrib/check-config.sh"
bash ${PATH_SCRIPTS}/check-config.sh || true