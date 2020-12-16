#!/bin/bash 

MONGODB_URI=${1}
if [ -z ${MONGODB_URI} ]
then
    read -p "MONGODB URI (Required): " MONGODB_URI
fi 

DRIVER_VERSION=${2:-1.4.4}
echo "Executing ... "
docker run --rm -e MONGODB_URI=${MONGODB_URI} \
    -v "$(pwd)":/workspace \
    -w /workspace/go start-go \
    "sed -i s/v[x0-9]\.[x0-9].[x0-9]/v${DRIVER_VERSION}/g /workspace/go/go.mod; \
    go run getstarted.go"
