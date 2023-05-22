# 先构建一个基础镜像
FROM centos:7.9.2009 as base

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 更新YUM源
RUN yum install -y epel-release https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm \
  && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo 

# 安装各类需要的软件
RUN yum install -y --setopt=tsflags=nodocs nginx redis mariadb-devel python36 python36-devel openldap-devel supervisor git wget unzip net-tools sshpass rsync sshfs docker-ce gcc \
  && yum -y clean all --enablerepo='*'

# 安装 pip 各类库
# 如果想用阿里云的镜像，可以在后面加上 -i https://mirrors.aliyun.com/pypi/simple/
RUN pip3 install --no-cache-dir --upgrade pip 
RUN pip3 install --no-cache-dir \
    gunicorn \
    mysqlclient \
    cryptography==36.0.2 \
    apscheduler==3.7.0 \
    asgiref==3.2.10 \
    Django==2.2.28 \
    channels==2.3.1 \
    channels_redis==2.4.1 \
    paramiko==2.11.0 \
    django-redis==4.10.0 \
    requests==2.22.0 \
    GitPython==3.0.8 \
    python-ldap==3.4.0 \
    openpyxl==3.0.3 \
    user_agents==2.2.0

RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8

# 系统环境变量
ENV TZ=Asia/Shanghai
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# 再用基础进行构建应用
FROM base

RUN echo -e '\n# Source definitions\n. /etc/profile\n' >> /root/.bashrc
RUN mkdir -p /data/spug/logs

# 拷贝文件
COPY temp/spug /data/spug/services

COPY install.d/init_spug /usr/bin/
COPY install.d/nginx.conf /etc/nginx/
COPY install.d/ssh_config /etc/ssh/
COPY install.d/spug.ini /etc/supervisord.d/
COPY install.d/redis.conf /etc/
COPY install.d/entrypoint.sh /

# 可配置的环境变量
ENV SECRET_KEY=WhatANiceDayToDie_
ENV MYSQL_DATABASE=spug
ENV MYSQL_USER=spug
ENV MYSQL_PASSWORD=_Mypwd
ENV MYSQL_HOST=mysql
ENV MYSQL_PORT=3306

# 需要持久化的目录
VOLUME /data/spug/repos
VOLUME /data/spug/logs

# 服务的端口
EXPOSE 80

CMD ["/entrypoint.sh"]