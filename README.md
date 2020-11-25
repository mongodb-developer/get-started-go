# Get-Started Go

Repository to help getting started with MongoDB Go driver connecting to MongoDB Atlas.

## Information

This Get-Started project uses [MongoDB Go driver](https://godoc.org/go.mongodb.org/mongo-driver/mongo) version 1.4.3 by default. Although you can change the driver version, the provided code example was only tested against the default version of MongoDB driver. There is no guarantee that the code sample will work for all possible versions of the driver.

## Pre-requisites 

### Docker 

Have Docker running on your machine. You can download and install from: https://docs.docker.com/install/

### MongoDB

In order to execute the code example, you need to specify `MONGODB_URI` environment variable to connect to a MongoDB cluster. You can *either* use : 

* [MongoDB Atlas](https://www.mongodb.com/cloud/atlas): If you don't have any you can create one by signing up [MongoDB Atlas Free-tier M0](https://docs.atlas.mongodb.com/getting-started/). Once you have an Atlas cluster running, use the [Connection URI](https://docs.atlas.mongodb.com/driver-connection/) string provided as the value of `MONGODB_URI`. 
* MongoDB hosted locally on your computer. The default connection URI for a standalone MongoDB running on the Docker host is `mongodb://host.docker.internal:27017`. Use this as the value of `MONGODB_URI`.

## Usage 

There are two methods to use this repository: 

* Build using [Visual Studio Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview) (Recommended if you are already using VS Code editor)
* Build directly using Docker


### Build using VS Code 

Pre-requisite: Install [Microsoft VS Code Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

1. Open file `./config.env`: 
   * Specify `MONGODB_URI` value
   * Specify `DRIVER_VERSION` value to use a different driver version than the default

2. With VS Code editor open, press `F1` to bring up the `Command Pallete` and type in `Remote-Containers: Open Folder in Container...`
3. You should see a progress bar while VS Code is building the Docker image

#### Execution Steps

Once the build completed, press `Ctrl + F5` to execute the code

See [VS Code Remote: FAQ](https://code.visualstudio.com/docs/remote/faq) for more information. 

 
### Build using Docker 

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

#### Execution Steps

1. Run the compiled Go code example by following below steps:
   * `cd ~/go`
   * `go build -v -o getstarted`
   * `./getstarted`

### Change driver version from within the Docker environment

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
