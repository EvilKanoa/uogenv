# uogenv (University of Guelph Environment)
This project is my attempt to create a reproducible, deterministic, and accurate development environment that mimics the University of Guelph's linux servers.

## Why?
No matter what course you're in, if it involves programming, you'll probably have to use the linux servers to test and compile. This process can be annoying or slow during development. To allow local compilation without worrying about a different environment, you can use a container that mimics the university's environment.

## How do I use this?
### Requirements
- Docker >= 18
- [Shared volumns](https://docs.docker.com/storage/volumes/) setup in Docker

### Usage
1. Run the docker image from docker hub.
```sh
docker run -p CONTAINER_PORT:22 -d -v HOST_SHARED_FOLDER:/home/student/shared evilkanoa/uogenv:latest
```
```sh
docker run \
	-p CONTAINER_PORT:22 \
	-d \
	-v HOST_SHARED_FOLDER:/home/student/shared \
	evilkanoa/uogenv:latest
```
> where `CONTAINER_PORT` is the port that should be binded on the host machine for ssh access and `HOST_SHARED_FOLDER` is a folder on the host computer that should be accessible from within the container. 

2. Connect to the uogenv container using: `ssh student@localhost -p CONTAINER_PORT` with password `student`. 

3. You can now expect all the tools that exist for the UoG servers and you can find your host files within `~/shared`.


