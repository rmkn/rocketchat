#!/bin/sh

/usr/bin/mongod &

exec "$@"
