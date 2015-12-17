#!/bin/bash

if [[ ! -x $(which aws) ]]; then
    echo "Requires AWS cli (brew install aws)" 1>&2
    exit 1
fi

BUCKET=www.latentninja.com
export AWS_DEFAULT_REGION=us-east-1

SRC=$(dirname $0)/public/
DST=/

source $(dirname $0)/s3vars.sh

aws s3 sync public s3://${BUCKET}/ --exclude .gitkeep --exclude \*.key --exclude \*.pem --exclude \*.crt --exclude mkcert

