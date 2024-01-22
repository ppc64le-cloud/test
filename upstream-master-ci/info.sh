docker version
docker info
curl -fsSL -o ${PATH_SCRIPTS}/check-config.sh "https://raw.githubusercontent.com/moby/moby/master/contrib/check-config.sh"
bash ${PATH_SCRIPTS}/check-config.sh || true