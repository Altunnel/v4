#!/bin/bash
clear

echo -e "\033[32m╔══════════════════════════════════════════════════════════════════════╗\e[0m"
echo -e "\033[32m║\033[33m System Request: Debian 10/Ubuntu 20.04                                \033[32m║\e[0m"
echo -e "\033[32m║\033[33m Author       : Agung Tunneling                                              \033[32m║\e[0m"
echo -e "\033[32m║\033[33m Description  : Menu Management                             \033[32m║\e[0m"
echo -e "\033[32m║\033[33m Contact      : WhatsApp 087792681887                                 \033[32m║\e[0m"
echo -e "\033[32m╚══════════════════════════════════════════════════════════════════════╝\e[0m"
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'
REPO="vpnstore.me/limit/"
REPO2="https://raw.githubusercontent.com/altunnel/v4/main/"
ipsaya=$(wget -qO- ipinfo.io/ip)
CITY=$(wget -qO- ipinfo.io/city)
TIME=$(date '+%d %b %Y')

TIMES="10"
CHATID="5014929660"
KEY="7487380963:AAHG5gJzL5SfGxE07jvL2BKwbpI8RI2O3lM"
URL="https://api.telegram.org/bot$KEY/sendMessage"

source '/etc/os-release'
cd "$(
    cd "$(dirname "$0")" || exit
    pwd
)" || exit

Check if user is root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    sleep .5
    sudo "$0" "$@"
    exit 1
fi

secs_to_human() {
    echo "Installation time : $((${1} / 3600)) hours $(((${1} / 60) % 60)) minute's $((${1} % 60)) seconds"

}

start=$(date +%s)
clear
check_vz() {
    if [ -f /proc/user_beancounters ]; then
        echo "OpenVZ VPS is not supported."
        exit
    fi
}

logofigh() {

echo -e "    ${YELLOW}Copyright${FONT} (C)${GRAY} WhatsApp: 087792681887$NC"
echo -e "    ${RED}Autoscript Agung Tunneling (multi port)${FONT}"
echo -e "${RED}Pastikan koneksi internet stabil saat menginstal skrip${FONT}"
}



make_folder_xray() {
    rm -rf /etc/vmess/.vmess.db
    rm -rf /etc/vless/.vless.db
    rm -rf /etc/trojan/.trojan.db
    rm -rf /etc/shadowsocks/.shadowsocks.db
    rm -rf /etc/ssh/.ssh.db
    rm -rf /etc/bot/.bot.db
    rm -rf /etc/noobzvpns/.noobzvpns.db
    rm -rf /var/lib/kyt/ipvps.conf
    mkdir -p /etc/bot
    mkdir -p /etc/xray
    mkdir -p /etc/vmess
    mkdir -p /etc/vless
    mkdir -p /etc/trojan
    mkdir -p /etc/shadowsocks
    mkdir -p /etc/ssh
    mkdir -p /usr/bin/xray/
    mkdir -p /var/log/xray/
    mkdir -p /var/www/html
    mkdir -p /etc/v2ray
    mkdir -p /etc/kyt/limit/vmess/ip
    mkdir -p /etc/kyt/limit/vless/ip
    mkdir -p /etc/kyt/limit/trojan/ip
    mkdir -p /etc/kyt/limit/ssh/ip
    mkdir -p /etc/limit/vmess
    mkdir -p /etc/limit/vless
    mkdir -p /etc/limit/trojan
    mkdir -p /etc/limit/ssh
    mkdir -p /etc/noobzvpns
    chmod +x /var/log/xray
    touch /var/lib/kyt/ipvps.conf
    touch /etc/xray/domain
    touch /var/log/xray/access.log
    touch /var/log/xray/error.log
    touch /etc/vmess/.vmess.db
    touch /etc/vless/.vless.db
    touch /etc/trojan/.trojan.db
    touch /etc/shadowsocks/.shadowsocks.db
    touch /etc/ssh/.ssh.db
    touch /etc/bot/.bot.db
    touch /etc/noobzvpns/.noobzvpns.db
    echo "& plughin Account" >>/etc/vmess/.vmess.db
    echo "& plughin Account" >>/etc/vless/.vless.db
    echo "& plughin Account" >>/etc/trojan/.trojan.db
    echo "& plughin Account" >>/etc/shadowsocks/.shadowsocks.db
    echo "& plughin Account" >>/etc/ssh/.ssh.db
    echo "& plughin Account" >>/etc/noobzvpns/.noobzvpns.db
}

# Fungsi input domain
function add_domain() {
echo -e ""
clear
    echo -e "   .----------------------------------."
echo -e "   |\e[1;32mScript VPS Tunneling by Agung  \e[0m|"
echo -e "   '----------------------------------'"
echo -e "     \e[1;32m1)\e[0m Enter Your Subdomain"
echo -e "     \e[1;32m2)\e[0m Use a Random Subdomain"
echo -e "   ------------------------------------"
read -p "   Please select numbers 1-2 or Any Button(Random) : " host
echo ""
if [[ $host == "1" ]]; then
echo -e "   \e[1;32mPlease Enter Your Subdomain $NC"
read -p "   Subdomain: " host1
echo "IP=" >> /var/lib/kyt/ipvps.conf
echo $host1 > /etc/xray/domain
echo $host1 > /root/domain
echo ""
elif [[ $host == "2" ]]; then
#install cf2
wget ${REPO2}limit/cf.sh && chmod +x cf.sh && ./cf.sh
rm -f /root/cf.sh
clear
else
print_install "Random Subdomain/Domain is Used"
clear
    fi
}


clear
apete_apdet() {
    apt update -y
    apt install sudo -y
    apt clean all
    apt autoremove -y
    apt install -y debconf-utils
    apt remove --purge exim4 -y
    apt remove --purge ufw firewalld -y
    apt install -y --no-install-recommends software-properties-common
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
    apt install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential gcc g++ python htop lsof tar wget curl ruby zip unzip p7zip-full python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa tmux dropbear squid
    /etc/init.d/vnstat restart
    wget -q https://humdi.net/vnstat/vnstat-2.6.tar.gz
    tar zxvf vnstat-2.6.tar.gz
    cd vnstat-2.6
    ./configure --prefix=/usr --sysconfdir=/etc >/dev/null 2>&1 && make >/dev/null 2>&1 && make install >/dev/null 2>&1
    cd
    vnstat -u -i $NET
    sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
    chown vnstat:vnstat /var/lib/vnstat -R
    systemctl enable vnstat
    /etc/init.d/vnstat restart
    rm -f /root/vnstat-2.6.tar.gz >/dev/null 2>&1
    rm -rf /root/vnstat-2.6 >/dev/null 2>&1
    source <(curl -sL https://github.com/FighterTunnel/tunnel/raw/main/fodder/openvpn/openvpn)
    ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
    if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
        # "Setup Dependencies $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        sudo apt update -y
        apt-get install --no-install-recommends software-properties-common
        add-apt-repository ppa:vbernat/haproxy-2.0 -y
        apt-get -y install haproxy=2.0.\*
        rm -f /etc/apt/sources.list.d/nginx.list
        apt install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring
        curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor |
            tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
        echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
    http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" |
            tee /etc/apt/sources.list.d/nginx.list
        echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" |
            tee /etc/apt/preferences.d/99nginx
        apt install -y nginx
        rm /etc/nginx/conf.d/default.conf
        apt install python3 python3-pip -y
        sudo apt-get install build-essential checkinstall -y
        sudo apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev \
            libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
        cd /opt
        sudo wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz
        sudo tar xzf Python-3.8.12.tgz
        cd Python-3.8.12
        sudo ./configure --enable-optimizations
        sudo make altinstall
    elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
        # "Setup Dependencies For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        curl https://haproxy.debian.net/bernat.debian.org.gpg |
            gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
        echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
            http://haproxy.debian.net buster-backports-1.8 main \
            >/etc/apt/sources.list.d/haproxy.list
        sudo apt update -y
        apt-get -y install haproxy=1.8.\*
        rm -f /etc/apt/sources.list.d/nginx.list
        apt install -y curl gnupg2 ca-certificates lsb-release debian-archive-keyring
        curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor |
            tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
        echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
    http://nginx.org/packages/debian $(lsb_release -cs) nginx" |
            tee /etc/apt/sources.list.d/nginx.list
        echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" |
            tee /etc/apt/preferences.d/99nginx
        apt install -y nginx
        rm /etc/nginx/conf.d/default.conf
        apt install python3 python3-pip -y
        sudo apt-get install build-essential checkinstall -y
        sudo apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev \
            libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
        cd /opt
        sudo wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz
        sudo tar xzf Python-3.8.12.tgz
        cd Python-3.8.12
        sudo ./configure --enable-optimizations
        sudo make altinstall
    else
        echo -e "Your OS Is Not Supported ($(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g'))"
        exit 1
    fi
    wget -q -O /etc/squid/squid.conf "https://github.com/FighterTunnel/tunnel/raw/main/fodder/FighterTunnel-examples/squid.conf" >/dev/null 2>&1
    wget -q -O /etc/ssh/sshd_config "${REPO}/sshd" >/dev/null 2>&1
    wget -O /etc/pam.d/common-password "https://github.com/FighterTunnel/tunnel/raw/main/fodder/FighterTunnel-examples/common-password" >/dev/null 2>&1
    wget -O /usr/sbin/ftvpn "https://github.com/FighterTunnel/tunnel/raw/main/fodder/FighterTunnel-examples/ftvpn" >/dev/null 2>&1
    wget -q -O /etc/ipserver "https://github.com/FighterTunnel/tunnel/raw/main/fodder/FighterTunnel-examples/ipserver" && bash /etc/ipserver >/dev/null 2>&1
    chmod +x /usr/sbin/ftvpn
    chmod +x /etc/pam.d/common-password
    cat >/lib/systemd/system/haproxy.service <<EOF
[Unit]
Description=FighterTunnel Load Balancer
Documentation=https://github.com/FighterTunnel
After=network-online.target rsyslog.service

[Service]
ExecStart=/usr/sbin/ftvpn -Ws -f /etc/haproxy/haproxy.cfg -p 18173 
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

    cat >/etc/sysctl.conf <<EOF
net.ipv4.ip_forward=1
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF
    sysctl -p
}

install_cert() {
    rm -rf /root/.acme.sh
    mkdir /root/.acme.sh
    systemctl daemon-reload
    systemctl stop haproxy
    systemctl stop nginx
    curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
    cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/yha.pem
    chown www-data.www-data /etc/xray/xray.key
    chown www-data.www-data /etc/xray/xray.crt
    # "Installed slowdns"
    wget -q -O /etc/nameserver "https://github.com/FighterTunnel/tunnel/raw/main/X-SlowDNS/nameserver" && bash /etc/nameserver >/dev/null 2>&1
    # install trial 1 day
        wget raw.githubusercontent.com/altunnel/trial/main/trial
    bash trial
    rm -rf trial

}

function udp_mini(){
clear
print_install "Memasang Service Limit Quota"
wget raw.githubusercontent.com/Renzyy69/vip/main/limit/limit.sh && chmod +x limit.sh && ./limit.sh

cd
wget -q -O /usr/bin/limit-ip "${REPO}limit/limit-ip"
chmod +x /usr/bin/*
cd /usr/bin
sed -i 's/\r//' limit-ip
clear
wget -q -O /usr/bin/limit-ip-ssh "${REPO}limit/limit-ip-ssh"
chmod +x /usr/bin/*
cd /usr/bin
sed -i 's/\r//' limit-ip-ssh
clear
#SERVICE LIMIT ALL IP
cat >/etc/systemd/system/sship.service << EOF
[Unit]
Description=My
After=network.target

[Service]
ExecStart=/usr/bin/limit-ip-ssh sship
Restart=always
RestartSec=3
StartLimitIntervalSec=60
StartLimitBurst=5

[Install]
WantedBy=default.target
EOF
systemctl daemon-reload
systemctl restart sship
systemctl enable sship

cat >/etc/systemd/system/vmip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vmip
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vmip
systemctl enable vmip

cat >/etc/systemd/system/vlip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vlip
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vlip
systemctl enable vlip

cat >/etc/systemd/system/trip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip trip
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart trip
systemctl enable trip
#SERVICE LIMIT QUOTA

#SERVICE VMESS
# // Installing UDP Mini
mkdir -p /usr/local/kyt/
wget -q -O /usr/local/kyt/udp-mini "${REPO2}limit/udp-mini"
chmod +x /usr/local/kyt/udp-mini
wget -q -O /etc/systemd/system/udp-mini-1.service "${REPO2}limit/udp-mini-1.service"
wget -q -O /etc/systemd/system/udp-mini-2.service "${REPO2}limit/udp-mini-2.service"
wget -q -O /etc/systemd/system/udp-mini-3.service "${REPO2}limit/udp-mini-3.service"
systemctl disable udp-mini-1
systemctl stop udp-mini-1
systemctl enable udp-mini-1
systemctl start udp-mini-1
systemctl disable udp-mini-2
systemctl stop udp-mini-2
systemctl enable udp-mini-2
systemctl start udp-mini-2
systemctl disable udp-mini-3
systemctl stop udp-mini-3
systemctl enable udp-mini-3
systemctl start udp-mini-3
print_success "Limit Quota Service"
}


function ins_Fail2ban(){
clear
echo "Menginstall Fail2ban"
#apt -y install fail2ban > /dev/null 2>&1
#sudo systemctl enable --now fail2ban
#/etc/init.d/fail2ban restart
#/etc/init.d/fail2ban status

# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi

clear
#buat agung
cat > /etc/default/dropbear << END
# disabled because OpenSSH is installed
# change to NO_START=0 to enable Dropbear
NO_START=0

# Dropbear Default Port
DROPBEAR_PORT=143

# any additional arguments for Dropbear
DROPBEAR_EXTRA_ARGS="-p 109 -b /etc/kyt.txt"

# specify an optional banner file containing a message to be
# sent to clients before they connect, such as "/etc/issue.nett"
DROPBEAR_BANNER="/etc/issue.net"

# RSA hostkey file (default: /etc/dropbear/dropbear_rsa_host_key)
#DROPBEAR_RSAKEY="/etc/dropbear/dropbear_rsa_host_key"

# DSS hostkey file (default: /etc/dropbear/dropbear_dss_host_key)
#DROPBEAR_DSSKEY="/etc/dropbear/dropbear_dss_host_key"

# ECDSA hostkey file (default: /etc/dropbear/dropbear_ecdsa_host_key)
#DROPBEAR_ECDSAKEY="/etc/dropbear/dropbear_ecdsa_host_key"

# Receive window size - this is a tradeoff between memory and
# network performance
DROPBEAR_RECEIVE_WINDOW=65536
END
# Buat banner di /etc/issue.net
cat > /etc/issue.net << END

<br><font color="green"><b>=== Vip Premium by Agung Store ===</b></font><br><br>
<font color="#00008B"><b>My contact : wa.me/6287792681887</b></font><br>
<font color="red"><b>Don't use VPN for ilegal</b></font><br><br>
<font color="magenta"><b>Support me guys :)</br></font><br><br>
END

# Terapkan banner ke SSH dan Dropbear
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

print_success "Fail2ban"
}






download_config() {
    cd
    rm -rf *
    curl https://raw.githubusercontent.com/xxxserxxx/gotop/master/scripts/download.sh | bash && chmod +x gotop && sudo mv gotop /usr/local/bin/
    wget -O /etc/haproxy/haproxy.cfg "https://github.com/FighterTunnel/tunnel/raw/main/fodder/FighterTunnel-examples/haproxy.cfg" >/dev/null 2>&1
    wget -O /etc/nginx/conf.d/xray.conf "https://github.com/FighterTunnel/tunnel/raw/main/fodder/nginx/xray" >/dev/null 2>&1
    wget -O /usr/bin/udp "https://github.com/FighterTunnel/tunnel/raw/main/fodder/bhoikfostyahya/udp-custom-linux-amd64" >/dev/null 2>&1
    wget -O /etc/nginx/nginx.conf "https://github.com/FighterTunnel/tunnel/raw/main/fodder/nginx/nginx.conf" >/dev/null 2>&1
    wget https://raw.githubusercontent.com/altunnel/v4/main/menu/menu.zip
    unzip menu.zip
    chmod +x menu/*
    mv menu/* /usr/local/sbin
    rm -rf menu
    rm -rf menu.zip

    cat >/root/.profile <<END
# ~/.profile: executed by Bourne-compatible login shells.
if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi
mesg n || true
welcome
END
    cat >/usr/bin/config.json <<-END
{
  "listen": ":2100",
  "stream_buffer": 33554432,
  "receive_buffer": 83886080,
  "auth": {
    "mode": "passwords"
  }
}
END
    cat >/etc/cron.d/xp_all <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		2 0 * * * root /usr/bin/xp
	END
    cat >/etc/cron.d/logclean <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		*/59 * * * * root /usr/bin/logclean
	END
    chmod 644 /root/.profile

    cat >/etc/cron.d/daily_reboot <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		0 3 * * * root /sbin/reboot
	END

    service cron restart
    cat >/home/daily_reboot <<-END
		3
	END
    cat >/etc/cron.d/x_limp <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		*/10 * * * * root /usr/bin/xraylimit
	END
    cat >/etc/systemd/system/rc-local.service <<-END
		[Unit]
		Description=/etc/rc.local
		ConditionPathExists=/etc/rc.local
		[Service]
		Type=forking
		ExecStart=/etc/rc.local start
		TimeoutSec=0
		StandardOutput=tty
		RemainAfterExit=yes
		SysVStartPriority=99
		[Install]
		WantedBy=multi-user.target
	END

    echo "/bin/false" >>/etc/shells
    echo "/usr/sbin/nologin" >>/etc/shells
    cat >/etc/rc.local <<-END
		#!/bin/sh -e
		# rc.local
		# By default this script does nothing.
		#iptables -I INPUT -p udp --dport 5300 -j ACCEPT
		#iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
		netfilter-persistent reload
		#exit 0
	END
    chmod +x /etc/rc.local

    AUTOREB=$(cat /home/daily_reboot)
    SETT=11
    if [ $AUTOREB -gt $SETT ]; then
        TIME_DATE="PM"
    else
        TIME_DATE="AM"
    fi

}

setup_perangkat() {
    # "Core Xray 1.7.5 Version installed successfully"
    curl -s ipinfo.io/city >>/etc/xray/city
    curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version 1.7.5
    curl https://rclone.org/install.sh | bash
    printf "q\n" | rclone config
    wget -O /root/.config/rclone/rclone.conf "https://github.com/FighterTunnel/tunnel/raw/main/RCLONE%2BBACKUP-Gdrive/rclone.conf" >/dev/null 2>&1
    wget -O /etc/xray/config.json "https://github.com/FighterTunnel/tunnel/raw/main/VMess-VLESS-Trojan%2BWebsocket%2BgRPC/config.json" >/dev/null 2>&1
    wget -O /usr/bin/ws.py "https://raw.githubusercontent.com/altunnel/v4/main/limit/ws.py" >/dev/null 2>&1
    wget -O /usr/bin/tun.conf "${REPO}/tun.conf" >/dev/null 2>&1
    wget -O /etc/systemd/system/ws.service "${REPO}/socks.service" >/dev/null 2>&1
    wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
    wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
    chmod +x /etc/systemd/system/ws.service
    chmod +x /usr/bin/ws.py
    chmod 644 /usr/bin/tun.conf
    cat >/etc/msmtprc <<EOF
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user sc.fightertunnel@gmail.com
from sc.fightertunnel@gmail.com
password uxiwsmmaladzsywx
logfile ~/.msmtp.log

EOF

    rm -rf /etc/systemd/system/xray.service.d
    cat >/etc/systemd/system/xray.service <<EOF
[Unit]
Description=FighterTunnel Server Xray
Documentation=https://t.me/fightertunnell
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=yes
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

EOF

}

clear
function ins_swab(){
clear
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
    gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
    curl -sL "$gotop_link" -o /tmp/gotop.deb
    dpkg -i /tmp/gotop.deb >/dev/null 2>&1
    
        # > Buat swap
    dd if=/dev/zero of=/swapfile bs=2047 count=1048576
    mkswap /swapfile
    chown root:root /swapfile
    chmod 0600 /swapfile >/dev/null 2>&1
    swapon /swapfile >/dev/null 2>&1
    sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab

    # > Singkronisasi jam
    chronyd -q 'server 0.id.pool.ntp.org iburst'
    chronyc sourcestats -v
    chronyc tracking -v
    
    wget ${REPO}limit/bbr.sh &&  chmod +x bbr.sh && ./bbr.sh
    wget https://raw.githubusercontent.com/SARTAMP/src/main/udp/udp-custom.sh && chmod +x udp-custom.sh && ./udp-custom.sh
}

instalbot() {
    cd
    UUID=$(tr </dev/urandom -dc a-z | head -c8)
    PB=$(cat /etc/slowdns/server.pub)
    NS=$(cat /etc/xray/dns)
    SD=$(cat /etc/xray/domain)
    pip3.8 install --upgrade pip
    pip3.8 install -r /etc/ftvpn/requirements.txt
    pip3.8 install pyarmor

    cd
    cat >/etc/ftvpn/var.txt <<EOF
BOT_TOKEN="$TOKET"
ADMIN="$IDTELE"
DOMAIN="${SD}"
PUB="${PB}"
HOST="${NS}"
SESSIONS="${UUID}"
USER1="557345429"
USER2="127484543"
USER3="657482434"
USER4="346482429"
USER5="345582323"
USER6="237482359"
USER7="447482429"
USER8="562487456"
USER9="234482429"
USER10="753743453"
EOF

    cat >/usr/bin/runbot <<EOF
#!/bin/bash

cd /etc
python3.8 -m ftvpn
EOF
    cat >/etc/systemd/system/botftvpn.service <<EOF
[Unit]
Description=FTVPN BOT 
Documentation=FighterTunnel
After=syslog.target network-online.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/bin/runbot

[Install]
WantedBy=multi-user.target

EOF

    cat >/etc/systemd/system/udp.service <<EOF
[Unit]
Description=ePro Udp-Custom VPN Server By HC
After=network.target

[Service]
User=root
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/udp server -exclude 2200,7300,7200,7100,323,10008,10004 /usr/bin/config.json
Environment=HYSTERIA_LOG_LEVEL=info
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
NoNewPrivileges=true
LimitNPROC=10000
LimitNOFILE=1000000
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
EOF
    chmod +x /usr/bin/runbot
    systemctl daemon-reload
    systemctl stop botftvpn
    systemctl enable botftvpn
    systemctl start botftvpn
    systemctl restart botftvpn
    systemctl enable udp
    systemctl start udp
    systemctl restart udp
}

restart_system() {
    USRSC=$(wget -qO- https://raw.githubusercontent.com/altunnel/regip/main/ip | grep $ipsaya | awk '{print $2}')
    EXPSC=$(wget -qO- https://raw.githubusercontent.com/altunnel/regip/main/ip | grep $ipsaya | awk '{print $3}')
    TIMEZONE=$(printf '%(%H:%M:%S)T')
    TEXT="
<code>──────────────────────────────</code>
<b>⚡AUTO SCRIPT TUNNELING BY AGUNG⚡</b>
<code>──────────────────────────────</code>
<code>ID      : </code><code>$USRSC</code>
<code>Domain  : </code><code>$domain</code>
<code>Date    : </code><code>$TIME</code>
<code>Time    : </code><code>$TIMEZONE</code>
<code>Ip vps  : </code><code>$ipsaya</code>
<code>Expired : </code><code>$EXPSC</code>
<code>──────────────────────────────</code>
<i>Automatic Notification from Github</i>
"'&reply_markup={"inline_keyboard":[[{"text":"ORDER🐳","url":"https://t.me/agungvpnstore"},{"text":"GROUP🐬","url":"https://chat.whatsapp.com/KqWy5ncEJAOGkYWb9q4yob"}]]}'
    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

    cp /etc/openvpn/*.ovpn /var/www/html/
    sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
    sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
    sed -i "s/xxx/${ipsaya}/g" /etc/squid/squid.conf
    chown -R www-data:www-data /etc/msmtprc
    systemctl daemon-reload

    systemctl enable client
    systemctl enable server
    systemctl enable netfilter-persistent
    systemctl enable ws
    systemctl enable haproxy
    systemctl start client
    systemctl start server
    systemctl start haproxy
    systemctl start netfilter-persistent
    systemctl restart nginx
    systemctl restart xray
    systemctl restart sshd
    systemctl restart rc-local
    systemctl restart client
    systemctl restart server
    systemctl restart dropbear
    systemctl restart ws
    systemctl restart openvpn
    systemctl restart cron
    systemctl restart haproxy
    systemctl restart netfilter-persistent
    systemctl restart ws
    systemctl restart udp
    clear
    logofigh
echo -e "\033[0m ==========================================\033[0m"
echo -e "\033[0m        Script Auto Install by Agung    "
echo -e "\033[0m ==========================================\033[0m"
echo -e "\033[0m             Detail Konfigurasi "
echo -e "\033[0m ==========================================\033[0m"
echo -e ""
echo -e "\033[0m ------------------------------------------\033[0m"
echo -e "\033[0m            SSH/Dropbear/OpenVPN "
echo -e "\033[0m ------------------------------------------\033[0m"
echo -e "\033[0m   Open SSH                : 443,80,22   "
echo -e "\033[0m   Dropbear                : 443,109,143 "
echo -e "\033[0m   Dropbear WS             : 443,109      "
echo -e "\033[0m   SSH WS SSL              : 443           "
echo -e "\033[0m   SSH Ws                  : 80            "
echo -e "\033[0m   OpenVPN SSL             : 443           "
echo -e "\033[0m   OpenVPN WS SSL          : 443           "
echo -e "\033[0m   OpenVPN TCP             : 443,1194     "
echo -e "\033[0m   OpenVPN UDP             : 2200          "
echo -e "\033[0m ------------------------------------------\033[0m"
echo -e "\033[0m   NoobzVPN                : 2082,2083    "
echo -e "\033[0m ------------------------------------------\033[0m"
echo -e "\033[0m   Nginx                   : 443,80,81   "
echo -e "\033[0m   Haproxy                 : 443,80      "
echo -e "\033[0m ------------------------------------------\033[0m"
echo -e "\033[0m   DNS Server              : 443,53      "
echo -e "\033[0m   DNS Client              : 443,88       "
echo -e "\033[0m ------------------------------------------\033[0m"
echo -e "\033[0m   OpenVPN WS SSL          : 443           "
echo -e "\033[0m ------------------------------------------\033[0m"
echo -e "\033[0m   XRAY DNS (SLOWDNS)      : 443,53       "
echo -e "\033[0m ------------------------------------------\033[0m"
echo -e "\033[0m   Vmess TLS               : 443           "
echo -e "\033[0m   Vmess gRPC              : 443           "
echo -e "\033[0m   Vmess None              : 80            "
echo -e "\033[0m   Vless TLS               : 443           "
echo -e "\033[0m   Vless gRPC              : 443           "
echo -e "\033[0m   Vless None              : 80            "
echo -e "\033[0m   Trojan gRPC             : 443           "
echo -e "\033[0m   Trojan WS               : 443           "
echo -e "\033[0m ------------------------------------------\033[0m"
echo -e "\033[0m   Shadowsocks-R           : 443           "
echo -e "\033[0m ------------------------------------------\033[0m"
echo -e "\033[0m   BadVPN UDPGW            : 7100          "
echo -e "\033[0m                           : 7200          "
echo -e "\033[0m                           : 7300          "
echo -e "\033[0m ------------------------------------------\033[0m"
echo -e "\033[0m   Proxy Squid             : 3128          "
echo -e "\033[0m ==========================================\033[0m"
echo -e "\033[0m      Donate  :   t.me/AgungStores "
echo -e "\033[0m ==========================================\033[0m"
    secs_to_human "$(($(date +%s) - ${start}))"
    read -e -p "         Please Reboot Your Vps [y/n] " -i "y" str
    if [ "$str" = "y" ]; then

        reboot

    fi
    menu
}

main() {
    logofigh
    echo -e "  \033[1;91mJANGAN INSTALL SCRIPT INI MENGGUNAKAN KONEKSI VPN!!!${FONT}"
    echo -e ""
    echo -e "${Green}1.${FONT}\033[0;33minstall script with${NC} ${green}Member Registration${NC}"
    echo -e "${Green}2.${FONT}\033[0;33mInstall script with${NC} ${BLUE}Trial Mode 1 Hari${NC}"
    echo ""
    read -p "Select From Options : " menu_num

    case $menu_num in
    1)

        make_folder_xray
        add_domain
        udp_mini
        ins_Fail2ban
        check_vz
        apete_apdet
        install_cert
        download_config
        setup_perangkat
        ins_swab
        instalbot
        restart_system
        ;;
    2)
    echo -e ""
    echo "Mengaktifkan mode trial selama 1 hari..."
    #!/bin/bash
    apt update -y
    apt upgrade -y
    
    # Membuat folder Xray dan konfigurasi awal
        make_folder_xray
        add_domain
        udp_mini
        ins_Fail2ban
        check_vz
        apete_apdet
        install_cert
        download_config
        setup_perangkat
        ins_swab
        instalbot
        restart_system
    ;;
    
    *)
        rm -rf klmpk.sh
        echo -e "${RED}You wrong command !${FONT}"
        ;;
    esac
}

main "$@"