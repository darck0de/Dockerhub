## Version 2.0 - Essentials
## docker build -t darkc0de/mypentestlab:essentials .
## docker run --rm -it darkc0de/mypentestlab:essentials
## Image size: 556 MB



####### Base Image Starts Here ----------------------
FROM ubuntu:18.04 AS builder
MAINTAINER darkc0de


RUN apt-get update

# Environment Variables
ENV HOME /root
ENV DEBIAN_FRONTEND=noninteractive

# Working Directory
WORKDIR /root
RUN mkdir ${HOME}/tools && \
    mkdir -p /usr/share/wordlists
###### Base Images Ends Here ----------------------

###### Essential image starts here ----------------------
FROM builder AS essentials

# Install Essentials
RUN apt-get install -y --no-install-recommends \
    build-essential \
    iputils-ping\
    git \
    vim \
    wget \
    curl \
    make \
    python \
    python-pip \
    python3 \
    python3-pip \
    perl \
    net-tools \
    zsh \
    nano \
    tmux

###### Essential image ends here ----------------------


###### Basic tools image starts here ----------------------
FROM essentials AS basictools

## Basic Tools installation

RUN apt-get install -y --no-install-recommends \
    rlwrap\
    ftp\
    openvpn \
    traceroute \
    whois \
    host \
    htop \
    dnsutils \
    figlet \
    tcpdump \
    telnet \
    unzip \
    p7zip-full \
    locate \
    tree \
    nmap \
    nikto \
    netcat \
    cewl \
    openssh-server \
    gcc \
    powerline

## zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \
    chsh -s /bin/zsh && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1 && \
    echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"

WORKDIR ${HOME}/tools
CMD /bin/zsh
