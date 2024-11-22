#!/bin/bash
cd /usr/local/
rm -rf sbin
rm -rf /usr/bin/enc
cd
mkdir /usr/local/sbin
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
clear

# Fungsi untuk enkripsi file
encrypt_file() {
    local file=$1
    local password="agung12?" # Ganti dengan password enkripsi Anda

    if [[ -f $file ]]; then
        openssl enc -aes-256-cbc -salt -in "$file" -out "${file}.enc" -k "$password"
        rm -f "$file" # Hapus file asli setelah dienkripsi
        echo "File $file telah dienkripsi menjadi ${file}.enc"
    else
        echo "File $file tidak ditemukan, tidak dapat dienkripsi."
    fi
}

# Fungsi untuk mendekripsi file dan langsung mengekstrak ZIP
decrypt_and_extract() {
    local encrypted_file=$1
    local password="agung12?" # Ganti dengan password enkripsi Anda

    if [[ -f $encrypted_file ]]; then
        # Mendekripsi file dan langsung meng-unzip ke direktori sementara
        openssl enc -d -aes-256-cbc -salt -in "$encrypted_file" -out "/tmp/decrypted_menu.zip" -k "$password"
        
        # Mengekstrak file ZIP yang sudah didekripsi
        unzip -o /tmp/decrypted_menu.zip -d /tmp/menu
        chmod +x /tmp/menu/*
        mv /tmp/menu/* /usr/local/sbin
        rm -rf /tmp/menu
        rm -f /tmp/decrypted_menu.zip
        echo "File telah didekripsi dan diekstrak."
    else
        echo "File $encrypted_file tidak ditemukan, tidak dapat didekripsi dan diekstrak."
    fi
}

fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m>"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}

res1() {
    wget https://raw.githubusercontent.com/altunnel/v4/main/limit/menu.zip
    encrypt_file "menu.zip"  # Enkripsi file menu.zip setelah diunduh
    
    wget -q -O /usr/bin/enc "https://scriptcjxrq91ay.agung-store.my.id:81/epro/epro"
    chmod +x /usr/bin/enc

    # Mendekripsi dan mengekstrak file menu.zip yang sudah dienkripsi
    decrypt_and_extract "menu.zip.enc"
    rm -rf update.sh
}

netfilter-persistent
clear
echo -e " \033[5;36m───────────────────────────────────────\033[0m"
echo -e " \e[0;101m            AGUNG TUNNELING            \e[0m"
echo -e " \033[5;36m───────────────────────────────────────\033[0m"
echo -e ""
echo -e "  \033[1;91m update script service\033[1;37m"
fun_bar 'res1'
echo -e " \033[5;36m───────────────────────────────────────\033[0m"
echo -e ""
echo -e " Done "

###########- COLOR CODE -##############