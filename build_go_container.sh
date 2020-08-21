#!/bin/bash

#docker build --no-cache --build-arg VERSION=testing-slim --build-arg GOVERSION=go1.14.6 -t jmaciasportela/dgo:latest .
#docker build --build-arg VERSION=testing-slim --build-arg GOVERSION=go1.14.6 -t jmaciasportela/dgo:latest .

function print_help {
    echo " "
    echo "build_go_container [options]"
    echo " "
    echo "options:"
    echo "-h                show brief help"
    echo "-image            specify debian base image tag (default: testing-slim)"
    echo "-go_version       specify go version (default: go1.14.6)"
    echo "-tag              specify tag (default: latest)"
    echo " "
    echo "Usage: build_go_container.sh -image testing-slim -go_version go1.14.6 -tag latest"
    echo " "
}

while test $# -gt 0; do
        case "$1" in        
            -h|--help)
                shift
                print_help
                exit 1;
                ;;
            -image)
                shift
                image=$1
                shift
                ;;
            -go_version)
                shift
                go_version=$1
                shift
                ;;    
            -tag)
                shift
                tag=$1
                shift
                ;;        
            *)
                echo "$1 is not a recognized flag!"
                print_help
                exit 1;
                ;;
        esac
done  

[ -z "$image" ] && echo "image tag is not set" && error=1
[ -z "$go_version" ] && echo "go_version is not set" && error=1
[ -z "$tag" ] && echo "tag is not set" && error=1
[ -z "$error" ] || exit 1


echo "Debian base image tag: $image";
echo "Go version: $go_version";
echo "Image jmaciasportela/dgo:$tag";

docker build --no-cache --build-arg VERSION=$image --build-arg GOVERSION=$go_version -t jmaciasportela/dgo:$tag .

echo " ";
echo "Done!";
