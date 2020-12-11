#!/bin/bash 

#read -p "DRIVER_VERSION (Leave empty to use default): " DRIVER_VERSION
MONGODB_URI=${1}
if [ -z ${MONGODB_URI} ]
then
    read -p "MONGODB URI (Required): " MONGODB_URI
fi 

DRIVER_VERSION=${2:-1.4.4}
echo "Executing ... "
docker run -v "$(pwd)":/workspace -e MONGODB_URI=${MONGODB_URI} \
    -w /workspace/go start-go \
    /bin/bash -c \
    "sed -i s/x.x.x/${DRIVER_VERSION}/g /home/ubuntu/go/go.mod; \
    cp /home/ubuntu/go/go.mod /workspace/go/go.mod; \
    go run getstarted.go"
