#
# Request-catcher Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

ENV GOROOT /usr/local/go
ENV GOPATH $HOME/go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

# Update & install packages for request-catcher
RUN apt-get update && \
    apt-get install -y wget curl git npm

# Get go
RUN wget https://storage.googleapis.com/golang/go1.10.linux-amd64.tar.gz && \
    tar -xvf go1.10.linux-amd64.tar.gz && \
    mv go /usr/local

# Download & setup request catcher/parcel
RUN go get github.com/jbowens/request-catcher && \
    npm install -g parcel-bundler && \
    cd /go/src/github.com/jbowens/request-catcher/frontend && \
    ./build.sh

## Install parcel via npm
COPY development.json /go/src/github.com/jbowens/request-catcher/config/development.json
 
WORKDIR /go/src/github.com/jbowens/request-catcher/

CMD ["go","run", "main.go", "config/development.json"]
