#!/bin/sh
apk --no-cache add tzdata
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" >  /etc/timezone
apk del tzdata

ts-node entrypoint.ts
