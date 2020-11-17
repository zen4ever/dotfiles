#!/bin/bash

# use on Debian Buster or Ubuntu
# run ./install_dev_tools_debian.sh without sudo
# logout after running and login again for group changes to take effect
set -euox pipefail
sudo apt-get update
sudo apt-get install -y tmux git

arch=$(uname -m)
final_arch="amd64"
if [ $arch = "aarch64" ]; then
    final_arch="arm64"
fi
release=$(lsb_release -is)

# install docker
if ! command -v docker &> /dev/null; then
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
    curl -fsSL https://download.docker.com/linux/${release,,}/gpg | sudo apt-key add -
    sudo add-apt-repository \
       "deb [arch=${final_arch}] https://download.docker.com/linux/${release,,} \
       $(lsb_release -cs) \
       stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    set +o pipefail
    sudo groupadd docker || true
    sudo usermod -aG docker $USER
    newgrp docker || true
    set -o pipefail
fi

if ! command -v go &> /dev/null; then
    # check the latest version at https://golang.org/dl/
    GO_VERSION=1.15.5
    curl -O https://dl.google.com/go/go${GO_VERSION}.linux-${final_arch}.tar.gz
    tar -xvf go${GO_VERSION}.linux-${final_arch}.tar.gz
    rm -f go${GO_VERSION}.linux-${final_arch}.tar.gz
    sudo rm -rf /usr/local/go
    sudo mv go /usr/local/

    mkdir -p $HOME/work
    if grep -q GOPATH $HOME/.profile; then
        echo "GOPATH config already exists"
    else
        echo "
export GOPATH=\$HOME/work
export PATH=\$PATH:/usr/local/go/bin:\$GOPATH/bin" >> $HOME/.profile
    fi
fi
