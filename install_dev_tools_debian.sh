#!/bin/bash

# use on Debian Buster
# run ./install_dev_tools_debian.sh without sudo
# logout after running and login again for group changes to take effect
set -euox pipefail
sudo apt-get update
sudo apt-get install -y tmux git

# install docker
if ! command -v docker &> /dev/null; then
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo groupadd docker || true
    sudo usermod -aG docker $USER
    newgrp docker || true
fi

if ! command -v go &> /dev/null; then
    # check the latest version at https://golang.org/dl/
    GO_VERSION=1.15.4
    curl -O https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz
    tar -xvf go${GO_VERSION}.linux-amd64.tar.gz
    rm -f go${GO_VERSION}.linux-amd64.tar.gz
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
