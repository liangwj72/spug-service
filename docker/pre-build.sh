#!/bin/bash

# 加载环境变量
./env.sh

# 下载必要的文件
mkdir -p temp
cd temp
if [ ! -d "./spug" ]; then
    # 创建目录
    mkdir -p spug/spug_web

    webFile="web_${SPUG_DOCKER_VERSION}.tar.gz"
    echo "下载 ${webFile}"
    curl -o web.tar.gz https://cdn.spug.cc/spug/${webFile}
    tar xf web.tar.gz -C ./spug/spug_web/
    rm -rf *.tar.gz

    echo "克隆 版本 ${SPUG_DOCKER_VERSION} 的源码"
    git clone -b $SPUG_DOCKER_VERSION https://gitee.com/openspug/spug.git src
    mv src/spug_api spug/
    rm -rf src

    cp ../install.d/overrides.py ./spug/spug_api/spug/

fi

