# syntax=docker/dockerfile:experimental
ARG VERSION=testing-slim
FROM debian:$VERSION
RUN echo $VERSION > image_version

LABEL maintainer="elmaci@gmail.com"
LABEL version="1.0"

#Install requirements
RUN apt-get update && \
    apt-get install -y  curl \
                        git \
                        mercurial \
                        make \
                        binutils \
                        bison \
                        gcc \
                        build-essential \
                        wget \
                        nano

#Install ZSH and enable some plugins
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/deluan/zsh-in-docker/master/zsh-in-docker.sh)" -- \
    -t robbyrussell \
    -p git \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions
COPY files/.zshrc /root/.zshrc

#Install GVM
ARG GVM_VERSION=master
ARG GOVERSION=go1.14.6
SHELL ["/bin/zsh", "-c"]
RUN zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/${GVM_VERSION}/binscripts/gvm-installer) && \
    source /root/.gvm/scripts/gvm && \
    gvm install $GOVERSION -B && \
    gvm use $GOVERSION --default
ENV GOPATH=$HOME/go
ENV GOBIN=$GOPATH/bin
ENV PATH=${PATH}:$GOBIN

# Clean OS
RUN apt-get clean all && \
    apt-get autoremove && \
    apt-get clean -y &&\
    rm -rf /var/lib/apt/lists/*

WORKDIR /projects/go_project
ENV SHELL=/bin/zsh
ENTRYPOINT [ "/bin/zsh" ]