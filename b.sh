#!/bin/sh

TAG="build-v18.03r48"

set -ex

docker build --pull --rm --compress -t solutionsoft/timemachine-sidecar:latest -t solutionsoft/timemachine-sidecar:${TAG} .
