set -e

dangling=$(sudo docker images --filter dangling=true -q)
if [ ! -z "${dangling}" ]; then
    echo "构建删除中间镜像 ${dangling}"
    sudo docker rmi ${dangling}
fi

noneImgs=$(sudo docker images | grep "<none>" | awk '{print $3}')
if [ ! -z "${noneImgs}" ]; then
    echo "删除所有 <none> 的镜像 ${noneImgs}"
    sudo docker rmi ${noneImgs}
fi

# 清除空间
#docker volume prune -f

set +e

echo "复核"
sudo docker images