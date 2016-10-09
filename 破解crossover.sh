#!/bin/sh
#这个脚本需要在root 权限下运行。
if [ `id -u` != "0" ]
then
echo "This script should run as root."
exit 1
fi
#下载并安装 crossover 15官方版
wget http://media.codeweavers.com/pub/crossover/cxlinux/demo/crossover_15.3.0-1.deb
dpkg -i crossover_15.3.0-1.deb
apt-get install -f
#安装 deepin-crossover_0.5.6.tar.xz 的修改版
wget https://git.ustclug.org/cat/wine-qq/raw/master/c14.tar.xz
tar -zxvf c14.tar.xz -C /
#从深度定制版 crossover 14中提取winewrapper.exe.so，并直接覆盖已经安装的文件
wget http://packages.linuxdeepin.com/deepin/pool/non-free/c/crossover/crossover_14.0.9-1_i386.deb
dpkg --extract crossover_14.0.9-1_i386.deb /tmp
rm /opt/cxoffice/lib/wine/winewrapper.exe.so
cp /tmp/opt/cxoffice/lib/wine/winewrapper.exe.so /opt/cxoffice/lib/wine/winewrapper.exe.so
exit 0
#运行完成后，crossover 15 没有任何功能限制。
#创建新容器及容器多开都可以正常使用，也没有时间限制。
#
#官方的试用版，在超过30天，旧的容器不能打开。
#容器从创建时起有30天试用期，各个容器互不影响。
#过期的容器依然可以使用命令，像纯粹wine 那样打开。
#
#比如，有创建一个容器叫做wineqq2015，默认放置在 ~/.cxoffice/wineqq2015
#
# export WINELOADER=/opt/cxoffice/bin/wineloader WINESERVER=/opt/cxoffice/lib/wine/wineserver WINEDLLPATH=/opt/cxoffice/lib/wine
# export WINEPREFIX=$HOME/.cxoffice/wineqq2015
# $WINELOADER "C:\Program Files\Tencent\QQ\Bin\QQ.exe"
#
