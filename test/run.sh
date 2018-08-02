#!/usr/bin/env bash

cd $(dirname $0)/..
ROOT_DIR=$(pwd)

# Fresh install from package-lock.json.
npm ci

# Link local packages into node_modules.
npm install ./packages/regenerator-runtime
npm install ./packages/regenerator-transform
npm install ./packages/regenerator-preset

# Make sure regenerator-preset can find regenerator-transform during
# Travis CI tests.
pushd ./packages/regenerator-preset
mkdir -p node_modules
cd node_modules
rm -rf regenerator-transform
ln -s "$ROOT_DIR/packages/regenerator-transform" .
popd

node test/run.js
