# 关于 Spug

这是基于官方的DockerFile脚本的优化，官方网站: https://spug.cc/

- 部署脚本见: [docker-compose.yml](example/docker-compose.yml)
- 镜像名见 : [env.sh](docker/env.sh)

根据官方文档，启动后要初始化才能用
```sh
# 创建数据库，并且添加一个管理用户
docker exec spug init_spug admin myPassword
```

## 主要解决的问题: 

- 原始镜像没有安装docker，没有办法进行编译，例如无法运行 maven 编译java项目
- 优化的目录结构
- 通过环境变量传递 python用于计算md5的 `SECRET_KEY` 值

## 镜像信息
```sh
# 可配置的环境变量
ENV SECRET_KEY=WhatANiceDayToDie_
ENV MYSQL_DATABASE=spug
ENV MYSQL_USER=spug
ENV MYSQL_PASSWORD=_Mypwd
ENV MYSQL_HOST=mysql
ENV MYSQL_PORT=3306

# 持久化的卷
VOLUME /data/spug/repos
VOLUME /data/spug/logs

# 监听的端口
EXPOSE 80

# 入口命令
CMD ["/entrypoint.sh"]
```

## 镜像内的目录结构
```
/data/spug : 基础目录
    - logs : 各个组件的日志，包括nginx的日志，建议持久化到本地
    - repos : 项目的文件，必须持续化到本地
    - services： spug的代码
```
