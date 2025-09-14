#!/bin/bash

source /etc/os-release
pre="/etc/apt/sources.list"
cp "${pre}" /root/

# Daftar mirror Indonesia
MIRRORS=(
  "http://kambing.ui.ac.id"
  "http://kartolo.sby.datautama.net.id"
  "http://repo.ugm.ac.id"
  "http://repo.unej.ac.id"
)

# Test kecepatan mirror pakai curl (ambil header aja biar cepat)
BEST_MIRROR=""
BEST_TIME=999999

echo "🔎 Mencari mirror tercepat..."
for M in "${MIRRORS[@]}"; do
    TIME=$(curl -o /dev/null -s -w '%{time_total}\n' "${M}" || echo 999999)
    echo "  - $M : $TIME detik"
    if (( $(echo "${TIME%.*}") < $(echo "${BEST_TIME%.*}") )); then
       BEST_TIME=$TIME
       BEST_MIRROR=$M
    fi
done

echo "✅ Mirror terbaik: $BEST_MIRROR"

# Tentukan codename sesuai distro
if [[ ${ID} == "ubuntu" ]]; then
    case ${VERSION_ID} in
        20.04) CODENAME="focal" ;;
        22.04) CODENAME="jammy" ;;
        24.04) CODENAME="noble" ;;
        24.10) CODENAME="oracular" ;;
        25.04) CODENAME="plucky" ;;
        *) echo "Versi Ubuntu tidak dikenali"; exit 1 ;;
    esac

    cat > ${pre} <<-END
deb $BEST_MIRROR/ubuntu/ $CODENAME main restricted universe multiverse
deb $BEST_MIRROR/ubuntu/ $CODENAME-updates main restricted universe multiverse
deb $BEST_MIRROR/ubuntu/ $CODENAME-security main restricted universe multiverse
deb $BEST_MIRROR/ubuntu/ $CODENAME-backports main restricted universe multiverse
END

elif [[ ${ID} == "debian" ]]; then
    case ${VERSION_ID} in
        10) CODENAME="buster" ;;
        11) CODENAME="bullseye" ;;
        12) CODENAME="bookworm" ;;
        13) CODENAME="trixie" ;;
        *) echo "Versi Debian tidak dikenali"; exit 1 ;;
    esac

    cat > ${pre} <<-END
deb $BEST_MIRROR/debian/ $CODENAME main contrib non-free
deb $BEST_MIRROR/debian/ $CODENAME-updates main contrib non-free
deb http://security.debian.org/debian-security $CODENAME-security main contrib non-free
END
else
    echo "Distro tidak didukung!"
    exit 1
fi

# Update dan upgrade
apt update && apt upgrade -y
rm repoindo.sh
