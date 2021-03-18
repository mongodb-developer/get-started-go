# Get-Started Go

Repository to help getting started with MongoDB Go driver connecting to MongoDB Atlas.

## Information

This Get-Started project uses [MongoDB Go driver](https://godoc.org/go.mongodb.org/mongo-driver/mongo) version 1.4.4 by default. Although you can change the driver version, the provided code example was only tested against the default version of MongoDB driver. There is no guarantee that the code sample will work for all possible versions of the driver.

## Pre-requisites 

### Docker 

Have Docker running on your machine. You can download and install from: https://docs.docker.com/install/

### MongoDB Atlas

In order to execute the code example, you need to specify `MONGODB_URI` environment variable to connect to a MongoDB cluster. If you don't have an existing cluster, you can create one by signing up [MongoDB Atlas Free-tier M0](https://docs.atlas.mongodb.com/getting-started/). 

##  Execution Steps 

Execute the helper shell script followed by the MongoDB URI that you would like to connect to. 

```
./get-started.sh "mongodb+srv://usr:pwd@example.mongodb.net/dbname?retryWrites=true"
```

To use a different driver version, specify the driver version after the MongoDB URI. For example:
```
./get-started.sh "mongodb+srv://usr:pwd@example.mongodb.net/dbname?retryWrites=true" 1.4.4
```

### Execute commands within the Docker environment 

You can invoke a terminal session within the Docker environment using the following command.
From the top level directory, execute: 
```
docker run -it -v "$(pwd):/workspace" -w /workspace/go ghcr.io/mongodb-developer/get-started-go "sh"
```


## Tutorials

* [MongoDB Go driver documentation](https://docs.mongodb.com/drivers/go)
* [Quickstart Golang and MongoDB: Starting and Setup](https://www.mongodb.com/blog/post/quick-start-golang--mongodb--starting-and-setup)


## About 

This project is part of the MongoDB Get-Started code examples. Please see [get-started-readme](https://github.com/mongodb-developer/get-started-readme) for more information. 
