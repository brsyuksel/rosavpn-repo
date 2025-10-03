#!/bin/bash

set -e

test_package() {
    cd packages/${PACKAGE}
    make test VERSION=${VERSION} ARCH=${ARCH}
    
}

dist_package() {
    cd packages/${PACKAGE}
    make package VERSION=${VERSION} ARCH=${ARCH}
}

if [ $# -eq 0 ]; then
    exit 1
fi

SUBCOMMAND=$1
shift

PACKAGE=""
VERSION=""
ARCH=""

while [ $# -gt 0 ]; do
    case "$1" in
    --package)
        PACKAGE="$2"
        shift 2
        ;;
    --version)
        VERSION="$2"
        shift 2
        ;;
    --arch)
        ARCH="$2"
        shift 2
        ;;
    *)
        exit 1
        ;;
    esac
done

if [ -z "$PACKAGE" ] || [ -z "$VERSION" ] || [ -z "$PACKAGE" ]; then
    exit 1
fi

case "$SUBCOMMAND" in
    test)
    test_package
    ;;
    dist)
    dist_package
    ;;
    *)
    exit 1
esac
