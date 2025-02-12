#!/bin/bash

source /etc/os-release
pre="/etc/apt/sources.list"
cp "${pre}" /root/

if [[ ${ID} == 'ubuntu' && $(echo "${VERSION_ID}" | cut -d. -f1) == 20 ]]; then
cat > ${pre} <<-END
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-updates main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-security main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-backports main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-proposed main restricted universe multiverse
END
fi

if [[ ${ID} == 'ubuntu' && $(echo "${VERSION_ID}" | cut -d. -f1) == 22 ]]; then
cat > ${pre} <<-END
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy-updates main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy-security main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy-backports main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy-proposed main restricted universe multiverse
END
fi

if [[ ${ID} == 'ubuntu' && $(echo "${VERSION_ID}" | cut -d. -f1) == 24 ]]; then
cat > ${pre} <<-END
deb http://kartolo.sby.datautama.net.id/ubuntu/ noble main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ noble-updates main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ noble-security main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ noble-backports main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ noble-proposed main restricted universe multiverse
END
fi

if [[ ${ID} == 'debian' && ${VERSION_ID} == 10 ]]; then
cat > ${pre} <<-END
deb http://kartolo.sby.datautama.net.id/debian/ buster main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ buster-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security/ buster/updates main contrib non-free
END
fi

if [[ ${ID} == 'debian' && ${VERSION_ID} == 11 ]]; then
cat > ${pre} <<-END
deb http://kartolo.sby.datautama.net.id/debian/ bullseye main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ bullseye-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security/ bullseye-security main contrib non-free
END
fi

if [[ ${ID} == 'debian' && ${VERSION_ID} == 12 ]]; then
cat > ${pre} <<-END
deb http://kartolo.sby.datautama.net.id/debian/ bookworm main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ bookworm-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security/ bookworm-security main contrib non-free
END
fi

apt update
apt upgrade -y  # Menambahkan flag -y agar upgrade otomatis
rm -- "$0"  # Menghapus skrip ini setelah selesai