#!/bin/bash

# Pastikan skrip dijalankan sebagai root
if [[ $EUID -ne 0 ]]; then
    echo "Skrip ini harus dijalankan sebagai root!" >&2
    exit 1
fi

# Mengambil informasi sistem
source /etc/os-release
pre="/etc/apt/sources.list"

# Membackup sources.list dengan timestamp
backup="/root/sources.list.backup_$(date +%F_%T)"
cp "${pre}" "${backup}"
echo "Backup disimpan di: ${backup}"

# Fungsi untuk mengecek apakah repo bisa diakses
check_repo() {
    local repo_url="$1"
    echo "Mengecek akses ke: ${repo_url}"
    
    if curl --head --silent --fail "${repo_url}" >/dev/null; then
        echo "Repo tersedia, memperbarui sources.list..."
        return 0
    else
        echo "Gagal mengakses repo: ${repo_url}, tidak akan mengganti sources.list!"
        return 1
    fi
}

# Fungsi untuk memperbarui repository jika repo tersedia
update_repo() {
    local repo_url="$1"
    local repo_sources="$2"
    
    if check_repo "${repo_url}"; then
        cat > "${pre}" <<-END
$repo_sources
END
        apt update && apt upgrade -y
    fi
}

# Ubuntu 20.04 (Focal)
if [[ ${ID} == "ubuntu" && $(echo "${VERSION_ID}" | cut -d. -f1) == 20 ]]; then
    update_repo "http://mirror.nus.edu.sg/ubuntu/dists/focal/Release" \
"deb http://mirror.nus.edu.sg/ubuntu focal main restricted universe multiverse
deb http://mirror.nus.edu.sg/ubuntu focal-updates main restricted universe multiverse
deb http://mirror.nus.edu.sg/ubuntu focal-security main restricted universe multiverse
deb http://mirror.nus.edu.sg/ubuntu focal-backports main restricted universe multiverse"
fi

# Ubuntu 22.04 (Jammy)
if [[ ${ID} == "ubuntu" && $(echo "${VERSION_ID}" | cut -d. -f1) == 22 ]]; then
    update_repo "http://mirror.nus.edu.sg/ubuntu/dists/jammy/Release" \
"deb http://mirror.nus.edu.sg/ubuntu jammy main restricted universe multiverse
deb http://mirror.nus.edu.sg/ubuntu jammy-updates main restricted universe multiverse
deb http://mirror.nus.edu.sg/ubuntu jammy-security main restricted universe multiverse
deb http://mirror.nus.edu.sg/ubuntu jammy-backports main restricted universe multiverse"
fi

# Ubuntu 24.04 (Noble)
if [[ ${ID} == "ubuntu" && $(echo "${VERSION_ID}" | cut -d. -f1) == 24 ]]; then
    update_repo "http://mirror.nus.edu.sg/ubuntu/dists/noble/Release" \
"deb http://mirror.nus.edu.sg/ubuntu noble main restricted universe multiverse
deb http://mirror.nus.edu.sg/ubuntu noble-updates main restricted universe multiverse
deb http://mirror.nus.edu.sg/ubuntu noble-security main restricted universe multiverse
deb http://mirror.nus.edu.sg/ubuntu noble-backports main restricted universe multiverse"
fi

# Debian 10 (Buster)
if [[ ${ID} == "debian" && ${VERSION_ID} == "10" ]]; then
    update_repo "http://mirror.nus.edu.sg/debian/dists/buster/Release" \
"deb http://mirror.nus.edu.sg/debian buster main contrib non-free
deb http://mirror.nus.edu.sg/debian buster-updates main contrib non-free
deb http://security.debian.org/debian-security buster/updates main contrib non-free"
fi

# Debian 11 (Bullseye)
if [[ ${ID} == "debian" && ${VERSION_ID} == "11" ]]; then
    update_repo "http://mirror.nus.edu.sg/debian/dists/bullseye/Release" \
"deb http://mirror.nus.edu.sg/debian bullseye main contrib non-free
deb http://mirror.nus.edu.sg/debian bullseye-updates main contrib non-free
deb http://security.debian.org/debian-security bullseye-security main contrib non-free"
fi

# Debian 12 (Bookworm)
if [[ ${ID} == "debian" && ${VERSION_ID} == "12" ]]; then
    update_repo "http://mirror.nus.edu.sg/debian/dists/bookworm/Release" \
"deb http://mirror.nus.edu.sg/debian bookworm main contrib non-free
deb http://mirror.nus.edu.sg/debian bookworm-updates main contrib non-free
deb http://security.debian.org/debian-security bookworm-security main contrib non-free"
fi

# Menghapus skrip hanya jika bernama reposg.sh
if [[ "$(basename "$0")" == "reposg.sh" ]]; then
    rm -- "$0"
fi