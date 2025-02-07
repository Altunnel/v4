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

# Daftar mirror Indonesia yang tersedia
MIRRORS=(
    "http://kartolo.sby.datautama.net.id"
    "http://kambing.ui.ac.id"
    "http://mirror.biznetgio.com"
    "http://mirror.cloud.id"
    "http://mirror.mikroskil.ac.id"
    "http://repo.ugm.ac.id"
    "http://mirror.unej.ac.id"
)

# Fungsi untuk mengecek kecepatan akses mirror
get_fastest_mirror() {
    local fastest_mirror=""
    local fastest_time=9999

    echo "🔍 Mencari mirror tercepat..."

    for mirror in "${MIRRORS[@]}"; do
        echo -n "⏳ Menguji kecepatan: $mirror ... "
        local time=$(curl -o /dev/null -s -w "%{time_connect}\n" "$mirror")
        
        if [[ $? -eq 0 && $(echo "$time < $fastest_time" | bc) -eq 1 ]]; then
            fastest_mirror="$mirror"
            fastest_time="$time"
        fi
        
        echo "${time}s"
    done

    if [[ -z "$fastest_mirror" ]]; then
        echo "❌ Tidak ada mirror yang bisa diakses! Menggunakan default global."
        fastest_mirror="http://archive.ubuntu.com" # Default jika semua gagal
    fi

    echo "✅ Mirror terbaik: $fastest_mirror"
    echo "$fastest_mirror"
}

# Menentukan mirror terbaik
BEST_MIRROR=$(get_fastest_mirror)

# Fungsi untuk memperbarui repository
update_repo() {
    local repo_url="$1"
    local repo_sources="$2"
    
    echo "🔄 Mengganti sources.list dengan mirror terbaik..."
    cat > "${pre}" <<-END
$repo_sources
END
    apt update && apt upgrade -y
}

# Ubuntu 20.04 (Focal)
if [[ ${ID} == "ubuntu" && $(echo "${VERSION_ID}" | cut -d. -f1) == 20 ]]; then
    update_repo "${BEST_MIRROR}/ubuntu/dists/focal/Release" \
"deb ${BEST_MIRROR}/ubuntu focal main restricted universe multiverse
deb ${BEST_MIRROR}/ubuntu focal-updates main restricted universe multiverse
deb ${BEST_MIRROR}/ubuntu focal-security main restricted universe multiverse
deb ${BEST_MIRROR}/ubuntu focal-backports main restricted universe multiverse"
fi

# Ubuntu 22.04 (Jammy)
if [[ ${ID} == "ubuntu" && $(echo "${VERSION_ID}" | cut -d. -f1) == 22 ]]; then
    update_repo "${BEST_MIRROR}/ubuntu/dists/jammy/Release" \
"deb ${BEST_MIRROR}/ubuntu jammy main restricted universe multiverse
deb ${BEST_MIRROR}/ubuntu jammy-updates main restricted universe multiverse
deb ${BEST_MIRROR}/ubuntu jammy-security main restricted universe multiverse
deb ${BEST_MIRROR}/ubuntu jammy-backports main restricted universe multiverse"
fi

# Ubuntu 24.04 (Noble)
if [[ ${ID} == "ubuntu" && $(echo "${VERSION_ID}" | cut -d. -f1) == 24 ]]; then
    update_repo "${BEST_MIRROR}/ubuntu/dists/noble/Release" \
"deb ${BEST_MIRROR}/ubuntu noble main restricted universe multiverse
deb ${BEST_MIRROR}/ubuntu noble-updates main restricted universe multiverse
deb ${BEST_MIRROR}/ubuntu noble-security main restricted universe multiverse
deb ${BEST_MIRROR}/ubuntu noble-backports main restricted universe multiverse"
fi

# Debian 10 (Buster)
if [[ ${ID} == "debian" && ${VERSION_ID} == "10" ]]; then
    update_repo "${BEST_MIRROR}/debian/dists/buster/Release" \
"deb ${BEST_MIRROR}/debian buster main contrib non-free
deb ${BEST_MIRROR}/debian buster-updates main contrib non-free
deb http://security.debian.org/debian-security buster/updates main contrib non-free"
fi

# Debian 11 (Bullseye)
if [[ ${ID} == "debian" && ${VERSION_ID} == "11" ]]; then
    update_repo "${BEST_MIRROR}/debian/dists/bullseye/Release" \
"deb ${BEST_MIRROR}/debian bullseye main contrib non-free
deb ${BEST_MIRROR}/debian bullseye-updates main contrib non-free
deb http://security.debian.org/debian-security bullseye-security main contrib non-free"
fi

# Debian 12 (Bookworm)
if [[ ${ID} == "debian" && ${VERSION_ID} == "12" ]]; then
    update_repo "${BEST_MIRROR}/debian/dists/bookworm/Release" \
"deb ${BEST_MIRROR}/debian bookworm main contrib non-free
deb ${BEST_MIRROR}/debian bookworm-updates main contrib non-free
deb http://security.debian.org/debian-security bookworm-security main contrib non-free"
fi

# Menghapus skrip hanya jika bernama repoindo.sh
if [[ "$(basename "$0")" == "repoindo.sh" ]]; then
    rm -- "$0"
fi