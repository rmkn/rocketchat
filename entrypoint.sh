#!/bin/sh

ulimit -f unlimited
ulimit -t unlimited
ulimit -v unlimited
ulimit -n 64000
ulimit -m unlimited
ulimit -u 64000
/usr/bin/mongod &

exec "$@"
