#!/bin/bash
trap 'exit' ERR

echo "<h3>Starting the build</h3>"

echo "<h3>Checkout source code<h/3>"
git clone ${REPO_URL} ${REPO_NAME}
cd ${REPO_NAME}
git checkout ${REPO_BRANCH}
cd .
echo

# comprobamos si existe kfr.json
KFR_CONFIG_PRESENT = false
KFR_CONFIG_FILE = ./kfr.json

if [ -r ./kfr.json ]; then
    KFR_CONFIG_PRESENT = true
fi

echo"<h3>Dependencies</h3>"

#
#
#
#

echo "<h3>Setup</h3>"
if ! ($KFR_CONFIG_PRESENT && $(cat $KFR_CONFIG_FILE | jq --raw-output '. | .setup.override//false')); then
    npm install
fi

if $KFR_CONFIG_PRESENT ; then
    source <(cat $KFR_CONFIG_FILE | jq --raw-output '. | .setup.custom[]?')
fi

echo "<h3>Test</h3>"
if ! ($KFR_CONFIG_PRESENT && $(cat $KFR_CONFIG_FILE | jq --raw-output '. | .test.override//false')); then
    npm test
fi

if $KFR_CONFIG_PRESENT ; then
    source <(cat $KFR_CONFIG_FILE | jq --raw-output '. | .test.custom[]?')
fi

exec "$@"