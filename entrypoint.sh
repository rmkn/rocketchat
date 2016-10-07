#!/bin/sh

service mongod start

exec "$@"
