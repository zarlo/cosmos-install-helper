#!/bin/bash
git clone https://github.com/CosmosOS/Cosmos.git --depth=1 --branch=master
git clone https://github.com/CosmosOS/IL2CPU.git --depth=1 --branch=master
git clone https://github.com/CosmosOS/XSharp.git --depth=1 --branch=master
git clone https://github.com/CosmosOS/Common.git --depth=1 --branch=master

DEPS_ALPINE=(
    make
    cdrkit
    qemu-system-x86_64
    dotnet7-runtime
    dotnet7-sdk
)

DEPS_DEBIAN=(
    make
    yasm
    genisoimage
    qemu-system-x86
    dotnet-sdk-6.0
    dotnet-runtime-6.0
)

DEPS_FEDORA=(
    make
    yasm
    genisoimage
    qemu-system-x86
    dotnet
)

DEPS_ARCH=(
    make
    yasm
    cdrtools
    qemu-system-x86
    dotnet-runtime
    dotnet-sdk
)

DEPS_SUSE=()

OS=
PACKAGE_UPDATE=
PACKAGE_INSTALL=
DEPS=

install()
{
    # Detect distro
    # Thanks to nanobyte: https://github.com/nanobyte-dev/nanobyte_os/blob/master/scripts/install_deps.sh
    if [ -x "$(command -v apk)" ]; then
        OS='alpine'
        PACKAGE_UPDATE='apk update'
        PACKAGE_INSTALL='apk add --no-cache'
        DEPS="${DEPS_ALPINE[@]}"
    elif [ -x "$(command -v apt-get)" ]; then
        OS='debian'
        PACKAGE_UPDATE='apt-get update'
        PACKAGE_INSTALL='apt-get -y install'
        DEPS="${DEPS_DEBIAN[@]}"
    elif [ -x "$(command -v dnf)" ]; then
        OS='fedora'
        PACKAGE_INSTALL='dnf install'
        DEPS="${DEPS_FEDORA[@]}"
    elif [ -x "$(command -v yum)" ]; then
        OS='fedora'
        PACKAGE_INSTALL='yum install'
        DEPS="${DEPS_FEDORA[@]}"
    elif [ -x "$(command -v zypper)" ]; then
        OS='suse'
        PACKAGE_INSTALL='zypper install'
        DEPS="$DEPS_SUSE"
    elif [ -x "$(command -v pacman)" ]; then
        OS='arch'
        PACKAGE_UPDATE='pacman -Syy'
        PACKAGE_INSTALL='pacman -S'
        DEPS="${DEPS_ARCH[@]}"
    else
        echo "Unknown operating system!"; 
    fi

    # Install dependencies
    echo ""
    echo "Will install dependencies by running the following command."
    echo ""
    echo " $ $PACKAGE_INSTALL ${DEPS[@]}"
    echo ""

    echo "here"

    read -p "Continue (y/n)?" choice
    case "$choice" in 
    y|Y ) ;;
    * ) echo "Exiting..."
            exit 0
            ;;
    esac

    $PACKAGE_UPDATE
    $PACKAGE_INSTALL ${DEPS[@]}

    exit 0
}

[[ $1 == "--install-pkg" ]] && sudo install || echo "Use --install-pkg to install packages if you want to install them!"
