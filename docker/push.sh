source ./env.sh

echo "先登录"
docker login

echo "准备推送镜像 ${IMG_NAME}"
read -p "按任意键继续..."
docker push ${IMG_NAME}
