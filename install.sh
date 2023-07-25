#!/bin/bash

#=== setup ===
rm -rf /etc/UDPCustom
mkdir -p /etc/UDPCustom
udp_dir='/etc/UDPCustom'
udp_file='/etc/UDPCustom/udp-custom'
sudo touch /etc/UDPCustom/udp-custom

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y wget
sudo apt install -y curl
sudo apt install -y dos2unix

source <(curl -sSL 'https://raw.githubusercontent.com/info-devf5r/UDP-Custom-Installer-Manager/main/module/module')

time_reboot() {
  print_center -ama "${a92:-VPS WILL REBOOT IN} $1 ${a93:-SECONDS}"
  REBOOT_TIMEOUT="$1"

  while [ $REBOOT_TIMEOUT -gt 0 ]; do
    print_center -ne "-$REBOOT_TIMEOUT-\r"
    sleep 1
    : $((REBOOT_TIMEOUT--))
  done
  rm /home/ubuntu/install.sh
  reboot
}

# Check Ubuntu version
if [ "$(lsb_release -rs)" = "8*|9*|10*|11*|16.04*|18.04*" ]; then
  clear
  print_center -ama -e "\e[1m\e[31m=====================================================\e[0m"
  print_center -ama -e "\e[1m\e[33m${a94:-this script is not compatible with your operating system}\e[0m"
  print_center -ama -e "\e[1m\e[33m ${a95:-Use Ubuntu 20 or higher}\e[0m"
  print_center -ama -e "\e[1m\e[31m=====================================================\e[0m"
  rm /home/ubuntu/install.sh
  exit 1
else
  clear
  echo ""
  print_center -ama "A Compatible OS/Environment Found"
  print_center -ama " > Installation begins...! <"
  sleep 3
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
  ufw disable &>/dev/null
  apt remove netfilter-persistent -y
  rm -rf /etc/UDPCustom/udp-custom
  print_center -ama "${a103:-setting up, please wait...}"
  sleep 3
  title "${a102:-INSTALLATION COMPLETED}"
  print_center -ama "${a103:-Type the command \nudp\n to show menu}"
  msg -bar
  time_reboot 10
fi
