echo "------------------------"
read -p "${IMG_NAME} 构建完成, 按任意键复核镜像信息"
sudo docker inspect ${IMG_NAME}
