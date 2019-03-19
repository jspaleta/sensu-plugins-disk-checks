[[ -z "$1" ]] && { echo "Parameter 1, Gem name is empty" ; exit 1; }
[[ -z "$2" ]] && { echo "Parameter 2, git repo is empty" ; exit 1; }
[[ -z "$3" ]] && { echo "Parameter 3, git ref is empty" ; exit 1; }

echo ${1} ${2} ${3}
# Build Debian asset
docker build --build-arg "ASSET_GEM=${1}" --build-arg "GIT_REPO=${2}"  --build-arg "GIT_REF=${3}" -t ruby-plugin-debian -f Dockerfile.debian .
docker cp $(docker create --rm ruby-plugin-debian:latest sleep 0):/${1}.tar.gz ./dist/${1}_debian.tar.gz

# Build Alpine asset
docker build --build-arg "ASSET_GEM=${1}" --build-arg "GIT_REPO=${2}"  --build-arg "GIT_REF=${3}" -t ruby-plugin-alpine:latest -f Dockerfile.alpine .
docker cp $(docker create --rm ruby-plugin-alpine:latest sleep 0):/${1}.tar.gz ./dist/${1}_alpine.tar.gz

# Build CentOS asset
docker build --build-arg "ASSET_GEM=${1}" --build-arg "GIT_REPO=${2}"  --build-arg "GIT_REF=${3}" -t ruby-plugin-centos:latest -f Dockerfile.centos .
docker cp $(docker create --rm ruby-plugin-centos:latest sleep 0):/${1}.tar.gz ./dist/${1}_centos.tar.gz



