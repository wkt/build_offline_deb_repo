# 生成deb离线安装包
## 1 安装docker
    请参考： https://www.runoob.com/docker/docker-tutorial.html

## 2 设置安装的系统
    编辑文件build_repo，填写需要离线安装软件的系统版本
    OS_NAME=ubuntu:18.04 #Debian、Ubuntu均支持，原则上其它类Debian的系统也同样支持

## 3 构建离线安装包
    在联网的机器上，运行：
    bash build_repo pack git openjdk-8-jdk # 创建git、openjdk-8-jdk的离线安装包

## 4 离线安装软件
    解压安装包
    #cd path_of_unpack
    #bash install.sh
