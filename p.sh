#!/bin/sh

TAG=build-v18.03r73-mesh

set -ex

docker push solutionsoft/timemachine-sidecar:${TAG}
#docker push solutionsoft/timemachine-sidecar:latest
