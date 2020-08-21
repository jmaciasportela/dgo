# jmaciasportela/dgo
Docker container with GVM + golang for development purposes

## Description

Docker container for daily development tasks with GVM preinstalled and ZSH. Easy switch between go versions. 
Use debian docker image as base image

[GVM](https://github.com/moovweb/gvm)

## Options

- image: which tag from debian image want to use as base image
- go_version: default go version preinstalled
- tag: tag to use for this docker image

## Build

``` bash
build_go_container [options]

options:
-h                show brief help
-image            specify debian base image tag (default: testing-slim)
-go_version       specify go version (default: go1.14.6)
-tag              specify tag (default: latest)

Usage: build_go_container.sh -image testing-slim -go_version go1.14.6 -tag latest
```

## Build example

```bash
$ ./build_go_container.sh -image testing-slim -go_version go1.14.6 -tag latest
Debian base image tag: testing-slim
Go version: go1.14.6
Image jmaciasportela/dgo:latest
[+] Building 108.4s (14/14) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                            0.0s
 => => transferring dockerfile: 37B                                                                                                                                             0.0s
 => [internal] load .dockerignore                                                                                                                                               0.0s
 => => transferring context: 2B                                                                                                                                                 0.0s
 => resolve image config for docker.io/docker/dockerfile:experimental                                                                                                           1.3s
 => CACHED docker-image://docker.io/docker/dockerfile:experimental@sha256:de85b2f3a3e8a2f7fe48e8e84a65f6fdd5cd5183afa6412fff9caa6871649c44                                      0.0s
 => [internal] load metadata for docker.io/library/debian:testing-slim                                                                                                          0.6s
 => CACHED [1/7] FROM docker.io/library/debian:testing-slim@sha256:c1cdf1c928243dda8352042d9ec1f876115a38b5757491e10f570fb34a4fc632                                             0.0s
 => [internal] load build context                                                                                                                                               0.0s
 => => transferring context: 3.64kB                                                                                                                                             0.0s
 => [2/7] RUN echo $VERSION > image_version                                                                                                                                     0.3s
 => [3/7] RUN apt-get update &&     apt-get install -y  curl                         git                         mercurial                         make                        47.6s
 => [4/7] RUN sh -c "$(wget -O- https://raw.githubusercontent.com/deluan/zsh-in-docker/master/zsh-in-docker.sh)" --     -t robbyrussell     -p git     -p https://github.com/  24.0s
 => [5/7] COPY files/.zshrc /root/.zshrc                                                                                                                                        0.0s
 => [6/7] RUN zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) &&     source /root/.gvm/scripts/gvm &&     gvm install go  20.1s
 => [7/7] RUN apt-get clean all &&     apt-get autoremove &&     apt-get clean -y &&    rm -rf /var/lib/apt/lists/*                                                             1.8s
 => exporting to image                                                                                                                                                         12.2s
 => => exporting layers                                                                                                                                                        12.2s
 => => writing image sha256:7c542f6115e97fa8a8fb3348b1f77f6550dc48a63ba6bb32177f7a56f105129c                                                                                    0.0s
 => => naming to docker.io/jmaciasportela/dgo:latest                                                                                                                            0.0s

Done!
```

## Run

```bash
docker run -tid -v /projects/go_project:/projects/go_project --name dgo jmaciasportela/dgo:latest
```

## Use

```bash
docker exec -ti dgo zsh -l
```

## Destroy

```bash
docker rm -f dgo
```

