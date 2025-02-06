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

# Fungsi untuk memperbarui repository
update_repo() {
    cat > "${pre}" <<-END
$1
END
    apt update && apt upgrade -y
}

# Ubuntu 20.04 (Focal)
if [[ ${ID} == "ubuntu" && $(echo "${VERSION_ID}" | cut -d. -f1) == 20 ]]; then
    update_repo "deb http://kartolo.sby.datautama.net.id/ubuntu/ focal main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-updates main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-security main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-backports main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-proposed main restricted universe multiverse"
fi

# Ubuntu 22.04 (Jammy)
if [[ ${ID} == "ubuntu" && $(echo "${VERSION_ID}" | cut -d. -f1) == 22 ]]; then
    update_repo "deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy-updates main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy-security main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy-backports main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy-proposed main restricted universe multiverse"
fi

# Ubuntu 24.04 (Noble)
if [[ ${ID} == "ubuntu" && $(echo "${VERSION_ID}" | cut -d. -f1) == 24 ]]; then
    update_repo "deb http://kartolo.sby.datautama.net.id/ubuntu/ noble main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ noble-updates main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ noble-security main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ noble-backports main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ noble-proposed main restricted universe multiverse"
fi

# Debian 10 (Buster)
if [[ ${ID} == "debian" && ${VERSION_ID} == "10" ]]; then
    update_repo "deb http://kartolo.sby.datautama.net.id/debian/ buster main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ buster-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security/ buster/updates main contrib non-free"
fi

# Debian 11 (Bullseye)
if [[ ${ID} == "debian" && ${VERSION_ID} == "11" ]]; then
    update_repo "deb http://kartolo.sby.datautama.net.id/debian/ bullseye main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ bullseye-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security/ bullseye-security main contrib non-free"
fi

# Debian 12 (Bookworm)
if [[ ${ID} == "debian" && ${VERSION_ID} == "12" ]]; then
    update_repo "deb http://kartolo.sby.datautama.net.id/debian/ bookworm main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ bookworm-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security/ bookworm-security main contrib non-free"
fi

# Menghapus skrip hanya jika bernama repoindo.sh
if [[ "$(basename "$0")" == "repoindo.sh" ]]; then
    rm -- "$0"
fi