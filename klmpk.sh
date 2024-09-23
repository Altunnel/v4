#!/bin/bash

download_url="https://raw.githubusercontent.com/altunnel/v4/main/klmpk_terenkripsi.sh"
encrypted_file="/root/klmpk_terenkripsi.sh"
decrypted_file="/usr/bin/setup.sh"

# Memeriksa apakah wget dan openssl terpasang
if ! command -v wget &> /dev/null; then
    echo "wget tidak ditemukan. Harap install wget terlebih dahulu."
    exit 1
fi

if ! command -v openssl &> /dev/null; then
    echo "openssl tidak ditemukan. Harap install openssl terlebih dahulu."
    exit 1
fi

# Meminta pengguna memasukkan kata sandi
echo -n "Masukkan kata sandi: "
read -s password
echo

# Mengunduh file terenkripsi
wget "$download_url" -O "$encrypted_file"

# Memeriksa apakah pengunduhan berhasil
if [ ! -f "$encrypted_file" ]; then
    echo "Pengunduhan file gagal."
    exit 1
fi

# Mendekripsi file menggunakan OpenSSL
openssl enc -aes-256-cbc -d -pass pass:"$password" -in "$encrypted_file" -out "$decrypted_file"

# Memeriksa apakah dekripsi berhasil
if [ ! -f "$decrypted_file" ]; then
    echo "Dekripsi file gagal."
    exit 1
fi

# Memberi izin eksekusi pada file terdekripsi
chmod +x "$decrypted_file"

# Menjalankan file terdekripsi
"$decrypted_file"

# Menghapus file terenkripsi
rm -f "$encrypted_file"
rm -f "$decrypted_file"
echo "Proses selesai."