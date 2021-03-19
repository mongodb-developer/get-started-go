#!/bin/bash
MONGODB_URI=${1}
if [ -z ${MONGODB_URI} ]
then
    read -p "MONGODB URI (Required): " MONGODB_URI
fi 

DRIVER_VERSION=${2:-1.5.0}
echo "Executing ... "
docker run --rm -e MONGODB_URI=${MONGODB_URI} \
    -v "$(pwd)":/workspace \
    -w /workspace/go ghcr.io/mongodb-developer/get-started-go \
    "sed -i 's/mongo-driver v[x0-9]\+\.[x0-9]\+\.[x0-9]\+/mongo-driver v${DRIVER_VERSION}/g' /workspace/go/go.mod; \
    go run getstarted.go"
