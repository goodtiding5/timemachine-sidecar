#!/bin/sh

#TAG="build-v18.03r73-mesh"
#TAG="build-v18.03r73"
#TAG="build-v18.03r72-mesh"
TAG="build-v18.03r72"
#TAG="build-v18.03r71-mesh"
#TAG="build-v18.03r71"
#TAG="build-v18.03r70-mesh"
#TAG="build-v18.03r70"
#TAG="build-v18.03r69-mesh"
#TAG="build-v18.03r69"
#TAG="build-v18.03r68-mesh"
#TAG="build-v18.03r68"
#TAG="build-v18.03r67"
#TAG="build-v18.03r66"
#TAG="build-v18.03r65update05-mesh"
#TAG="build-v18.03r65update04-mesh"
#TAG="build-v18.03r65update03-mesh"
#TAG="build-v18.03r65update02-mesh"

set -ex

docker build --pull --rm --compress -t solutionsoft/timemachine-sidecar:latest -t solutionsoft/timemachine-sidecar:${TAG} .
