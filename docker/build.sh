source ./env.sh

# 预下载spug的内容
./pre-build.sh

# 构建镜像
docker build -t ${IMG_NAME} .

./after-build.sh