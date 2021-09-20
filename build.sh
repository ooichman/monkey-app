#!/bin/bash

if [[ -z ${REGISTRY} ]]; then
	echo "No REGISTRY is set ... exiting"
	exit 1
else
	buildah bud -f Containerfile -t ${REGISTRY}/monkey-app && \
	buildah push ${REGISTRY}/monkey-app
fi
