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

1. Build Docker image with a tag name. Within the top level directory execute: 
   ```
   docker build . -t start-go
   ```
   This will build a docker image with a tag name `start-go`. 

2. Execute the helper shell script followed by the MongoDB URI that you would like to connect to. 
      ```
      ./get-started.sh "mongodb+srv://usr:pwd@example.mongodb.net/dbname?retryWrites=true"
      ```

   To use a different driver version, specify the driver version after the MongoDB URI. For example:
      ```
      ./get-started.sh "mongodb+srv://usr:pwd@example.mongodb.net/dbname?retryWrites=true" 1.4.3
      ```

## Alternative Execution Steps (without helper)

#### Build Steps

1. Build Docker image with a tag name. Within this directory execute: 
   * To use the default driver version and specify `MONGODB_URI`:
      ```
      docker build . -t start-go --build-arg MONGODB_URI="mongodb+srv://usr:pwd@example.mongodb.net/dbname?retryWrites=true"
      ```
   * To use a different driver version and specify `MONGODB_URI`. For example:
      ```
      docker build . -t start-go --build-arg DRIVER_VERSION=1.2.0 --build-arg MONGODB_URI="mongodb+srv://usr:pwd@example.mongodb.net/dbname?retryWrites=true"
      ```
   This will build a docker image with a tag name `start-go`. 
   As a result of the build, the example code is compiled for the specified driver version and ready to be executed.

2. Run the Docker image by executing:
   ```
   docker run --tty --interactive --hostname golang start-go
   ```

   The command above will run a `start-go` tagged Docker image. Sets the hostname as `golang`. 

#### Execution

1. Run the compiled Go code example by following below steps:
   * `go build -v -o getstarted`
   * `./getstarted`

#### Change driver version from within the Docker environment

For running the code example in a different driver version from the one built on the image:

1. Change the driver version within the project file [go.mod](go/go.mod)
2. Re-build the sample code:
   ```
   go build -v -o getstarted
   ```

1. Run the compiled Go code example by following below steps:
   * `go build -v -o getstarted`
   * `./getstarted`

#### Change driver version from within the Docker environment

For running the code example in a different driver version from the one built on the image:

1. Change the driver version within the project file [go.mod](go/go.mod)
2. Re-build the sample code:
   ```
   go build -v -o getstarted
   ```

From within the docker environment, you can also change the `MONGODB_URI` by changing the environment variable: 

```sh
export MONGODB_URI="mongodb+srv://usr:pwd@new.mongodb.net/dbname?retryWrites=true"
```

## Tutorials

* [MongoDB Go driver documentation](https://docs.mongodb.com/drivers/go)
* [Quickstart Golang and MongoDB: Starting and Setup](https://www.mongodb.com/blog/post/quick-start-golang--mongodb--starting-and-setup)


## About 

This project is part of the MongoDB Get-Started code examples. Please see [get-started-readme](https://github.com/mongodb-developer/get-started-readme) for more information. 
