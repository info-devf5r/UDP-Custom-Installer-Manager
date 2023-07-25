#!/bin/sh
if [ $1 == "amd64" ]; then
    ARCH="64"
    FNAME="amd64"
elif [ $1 == "arm64" ]; then
    ARCH="arm64-v8a"
    FNAME="arm64"
else
    ARCH="64"
    FNAME="amd64"
fi

rm -rf /etc/UDPCustom
mkdir -p /etc/UDPCustom
udp_dir='/etc/UDPCustom'
udp_file='/etc/UDPCustom/udp-custom'
touch /etc/UDPCustom/udp-custom
rm -rf $udp_file
rm -rf /etc/UDPCustom/udp-custom
rm -rf /etc/limiter.sh
rm -rf /etc/UDPCustom/limiter.sh
rm -rf /etc/UDPCustom/module
rm -rf /usr/bin/udp
source <(curl -sSL 'https://raw.githubusercontent.com/info-devf5r/UDP-Custom-Installer-Manager/main/module/module') &>/dev/null
wget -O /etc/UDPCustom/module 'https://raw.githubusercontent.com/info-devf5r/UDP-Custom-Installer-Manager/main/module/module' &>/dev/null
wget -O /etc/UDPCustom/udp-custom 'https://raw.githubusercontent.com/info-devf5r/UDP-Custom-Installer-Manager/main/bin/udp-custom' &>/dev/null
chmod +x /etc/UDPCustom/udp-custom
chmod +x /etc/UDPCustom/module
bash /etc/UDPCustom/udp-custom
wget -O /etc/limiter.sh 'https://raw.githubusercontent.com/info-devf5r/UDP-Custom-Installer-Manager/main/module/limiter.sh'
chmod +x /etc/limiter.sh
cp /etc/limiter.sh /etc/UDPCustom
wget -O /usr/bin/udp 'https://raw.githubusercontent.com/info-devf5r/UDP-Custom-Installer-Manager/main/module/udp'
chmod +x /usr/bin/udp
apt remove netfilter-persistent -y
rm -rf /etc/UDPCustom/udp-custom

cd ../../
