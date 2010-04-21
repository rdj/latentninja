#!/bin/bash

. $(dirname $0)/s3vars.sh

SOURCE=$(dirname $0)/public/
BUCKET=s3.latentninja.com
DEST=/

s3sync -p -r --expires="Mon, 09 Dec 2019 04:45:17 GMT" --cache-control="max-age=311040000" --progress ${SOURCE} ${BUCKET}:${DEST}
