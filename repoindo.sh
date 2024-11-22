#!/bin/bash

# Mengambil informasi sistem
source /etc/os-release
pre="/etc/apt/sources.list"
cp "${pre}" /root/  # Membackup sources.list

# Ubuntu 20.04
if [[ ${ID} == 'ubuntu' && $(echo "${VERSION_ID}" | cut -d. -f1) == 20 ]]; then
    cat > ${pre} <<-END
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-updates main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-security main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-backports main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-proposed main restricted universe multiverse
END
    apt update
    apt upgrade -y
    rm repoindo.sh
fi

# Ubuntu 22.04
if [[ ${ID} == 'ubuntu' && $(echo "${VERSION_ID}" | cut -d. -f1) == 22 ]]; then
    cat > ${pre} <<-END
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy-updates main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy-security main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy-backports main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ jammy-proposed main restricted universe multiverse
END
    apt update
    apt upgrade -y
    rm repoindo.sh
fi

# Ubuntu 24.04 (placeholder untuk nama kode)
if [[ ${ID} == 'ubuntu' && $(echo "${VERSION_ID}" | cut -d. -f1) == 24 ]]; then
    cat > ${pre} <<-END
deb http://kartolo.sby.datautama.net.id/ubuntu/ lunar main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ lunar-updates main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ lunar-security main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ lunar-backports main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ lunar-proposed main restricted universe multiverse
END
    apt update
    apt upgrade -y
    rm repoindo.sh
fi

# Debian 10 (buster)
if [[ ${ID} == 'debian' && ${VERSION_ID} == 10 ]]; then
    cat > ${pre} <<-END
deb http://kartolo.sby.datautama.net.id/debian/ buster main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ buster-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security/ buster/updates main contrib non-free
END
    apt update
    apt upgrade -y
    rm repoindo.sh
fi

# Debian 11 (bullseye)
if [[ ${ID} == 'debian' && ${VERSION_ID} == 11 ]]; then
    cat > ${pre} <<-END
deb http://kartolo.sby.datautama.net.id/debian/ bullseye main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ bullseye-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security/ bullseye-security main contrib non-free
END
    apt update
    apt upgrade -y
    rm repoindo.sh
fi

# Debian 12 (bookworm)
if [[ ${ID} == 'debian' && ${VERSION_ID} == 12 ]]; then
    cat > ${pre} <<-END
deb http://kartolo.sby.datautama.net.id/debian/ bookworm main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ bookworm-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security/ bookworm-security main contrib non-free
END
    apt update
    apt upgrade -y
    rm repoindo.sh
fi