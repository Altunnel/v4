#!/bin/bash

cd /usr/local/
rm -rf sbin
rm -rf /usr/bin/enc
cd
mkdir /usr/local/sbin
mkdir /usr/local/secure_files   # Membuat folder untuk menyimpan file yang telah didekripsi

# Ambil tanggal dari server
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

# Fungsi untuk menampilkan output berwarna
red() { echo -e "\\033[32;1m${*}\\033[0m"; }

# Fungsi untuk menampilkan loading bar
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

# Fungsi untuk menginstal, mengenkripsi, dan mendekripsi
res1() {
    # Download dan unzip menu
    wget https://raw.githubusercontent.com/altunnel/v4/main/limit/menu.zip
    unzip menu.zip
    chmod +x menu/*
    
    # Pastikan 'enc' tersedia untuk enkripsi
    if command -v enc &> /dev/null; then
        for file in menu/*; do
            enc "$file"  # Enkripsi setiap file
        done
    else
        echo -e "\033[1;91mAlat enkripsi 'enc' tidak ditemukan. Melewati enkripsi.\033[0m"
    fi
    
    # Pindahkan file terenkripsi ke /usr/local/sbin
    mv menu/* /usr/local/sbin
    
    # Bersihkan file sementara
    rm -rf menu
    rm -rf menu.zip
    rm -rf update.sh
}

# Fungsi untuk mendekripsi file yang ada di /usr/local/sbin dan memindahkannya ke lokasi aman
decrypt_files() {
    echo -e "\033[1;37mMenjalankan dekripsi...\033[0m"
    
    # Periksa apakah 'enc' ada untuk dekripsi
    if command -v enc &> /dev/null; then
        for file in /usr/local/sbin/*; do
            enc -d "$file"  # Dekripsi file
            mv "$file" /usr/local/secure_files/  # Pindahkan file yang didekripsi ke lokasi aman
        done
        echo -e "\033[1;32mFile telah didekripsi dan dipindahkan ke /usr/local/secure_files/\033[0m"
    else
        echo -e "\033[1;91mAlat enkripsi 'enc' tidak ditemukan untuk dekripsi. Dekripsi gagal.\033[0m"
    fi
}

# Pastikan netfilter-persistent tersedia (langkah opsional, bisa dihapus jika tidak diperlukan)
netfilter-persistent

# Bersihkan layar dan tampilkan banner
clear
echo -e " \033[5;36m───────────────────────────────────────\033[0m"
echo -e " \e[0;101m            AGUNG TUNNELING            \e[0m"
echo -e " \033[5;36m───────────────────────────────────────\033[0m"
echo -e ""
echo -e "  \033[1;91m update script service\033[1;37m"

# Jalankan fungsi untuk instalasi, enkripsi, dan dekripsi
fun_bar 'res1'
decrypt_files  # Memanggil fungsi dekripsi setelah instalasi

# Tampilkan pesan selesai
echo -e " \033[5;36m───────────────────────────────────────\033[0m"
echo -e ""
echo -e " Selesai "