#!/bin/sh

TAG=build-v18.03r72

set -ex

docker push solutionsoft/timemachine-sidecar:${TAG}
#docker push solutionsoft/timemachine-sidecar:latest
