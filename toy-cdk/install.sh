#!/bin/bash
set -eu

scriptdir=$(cd $(dirname $0) && pwd)

darwin=false
if uname -a | grep Darwin; then
  darwin=true
fi

function install_node {
  pushd .node-versions
  archive_name=nodejs-${NODE_VERSION}.archive

  if ${darwin}; then
    node_url=https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-darwin-x64.tar.gz
    dir_name=node-v${NODE_VERSION}-darwin-x64
    tar_flags=zxf
  else
    node_url=https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz
    dir_name=node-v${NODE_VERSION}-linux-x64
    tar_flags=xf
  fi

  if [ ! -f ${archive_name} ]; then
    echo "Downloading NodeJS from ${node_url}"
    curl -o ${archive_name} ${node_url}
    tar ${tar_flags} ${archive_name}
  fi

  export PATH=$(pwd)/${dir_name}/bin:${PATH}
  export PATH=${scriptdir}/node_modules/.bin:${PATH}
  pushd ${scriptdir}
  npm install yarn
  rm package-lock.json
  popd
  popd
}

function use_version {
  package=$1
  version=$2
  echo "Using ${package} version ${version}"
  if ${darwin}; then
    sed -i ".bak" -E "s|(${package}.*: )\".*\"|\1\"${version}\"|g" ${scriptdir}/package.json
  else
    sed -i -E "s|(${package}.*: )\".*\"|\1\"${version}\"|g" ${scriptdir}/package.json
  fi

}

mkdir -p ${scriptdir}/.node-versions
pushd ${scriptdir}

echo "Installing NodeJS ${NODE_VERSION}"
install_node

use_version "aws-cdk" ${CDK_VERSION}
use_version "crc32-stream" ${CRC32_STREAM_VERSION}
use_version "archiver" ${ARCHIVER_VERSION}

pushd ${scriptdir}

yarn install

echo " - NODE_VERSION: $(node --version)"
echo " - CDK_VERSION: $(cdk --version)"
echo " - CRC32_STREAM_VERSION: $(node -p 'require(path.join(path.dirname(path.dirname(require.resolve("crc32-stream"))), "package.json")).version')"
echo " - ARCHIVER_VERSION: $(node -p 'require(path.join(path.dirname(require.resolve("archiver")), "package.json")).version')"
