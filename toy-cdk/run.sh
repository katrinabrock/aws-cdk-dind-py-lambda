#!/bin/bash
set -eu

echo "Deploying..."
set +e
cdk deploy --require-approval never
exit_code=$?
set -e

if [ ${exit_code} -eq 0 ]; then
  echo -e "Success"
else
  echo -e "Failure"
fi

echo " - NODE_VERSION: $(node --version)"
echo " - CDK_VERSION: $(cdk --version)"
echo " - CRC32_STREAM_VERSION: $(node -p 'require(path.join(path.dirname(path.dirname(require.resolve("crc32-stream"))), "package.json")).version')"
echo " - ARCHIVER_VERSION: $(node -p 'require(path.join(path.dirname(require.resolve("archiver")), "package.json")).version')"

popd

exit ${exit_code}
