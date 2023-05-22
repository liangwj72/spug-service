#!/bin/bash
#
set -e

if [ -e /root/.bashrc ]; then
    source /root/.bashrc
fi

if [ -z "${SECRET_KEY}" ]; then
    echo "缺失环境变量 SECRET_KEY"
else
    exec supervisord -c /etc/supervisord.conf
fi
