# My Dockerfile

# Image - Base Image
FROM kalilinux/kali-rolling:latest as base

## Update
RUN apt-get update -y

# Image - essentials Image
FROM base as essentials

## Install essential packages
RUN \
    apt-get install -y --no-install-recommends \
    build-essential \
    tmux \
    gcc \
    htop \
    dnsutils \
    net-tools \
    tcpdump \
    telnet \
    rlwrap \
    iputils-ping \
    git \
    zsh \
    curl \
    unzip \
    p7zip-full \
    locate \
    tree \
    openvpn \
    vim \
    wget \
    ftp \
    python3 \
    python \
    python3-pip \
    make \
    nano

# Image - tools Image
FROM essentials as tools
RUN \
    apt-get install -y --no-install-recommends \
    nmap \
    masscan \
    nikto \
    netcat \
    cewl \
    traceroute \
    whois \
    host    

### Install tools from github
RUN mkdir -p /root/tools
WORKDIR /root/tools/

#### Download Sublist3r
RUN	git clone --depth 1 https://github.com/aboul3la/Sublist3r.git

###Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### Download Autorecon Dependency

RUN apt-get install -y --no-install-recommends enum4linux gobuster nbtscan onesixtyone oscanner smbclient smbmap smtp-user-enum snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf

### Metasploit
RUN apt-get install -y --no-install-recommends metasploit-framework exploitdb

### Sqlmap, John
RUN apt-get install -y --no-install-recommends sqlmap john

### Seclist
#RUN apt-get install -y --no-install-recommends seclists

### Autorecon
RUN git clone --depth 1 https://github.com/Tib3rius/AutoRecon.git
WORKDIR /root/tools/AutoRecon/
RUN python3 -m pip install -r requirements.txt
WORKDIR /root/tools/

### Impacket
RUN git clone --depth 1 https://github.com/SecureAuthCorp/impacket.git && cd impacket \
    pip3 install . && python3 setup.py install

### Mobile Tools
RUN apt-get install -y --no-install-recommends jadx apktool

### PIP Requests
RUN pip3 install requests


## Cleaning
RUN	apt-get clean && rm -rf /var/lib/apt/lists/*

## Last command
ENTRYPOINT /bin/zsh
