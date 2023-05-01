# is MacOS ARM
FROM  kalilinux/kali-rolling:arm64

ENV LANG=ja_JP.UTF-8

# Get the latest everything
RUN apt -y update && \
    apt -y upgrade

# Get the Kali default tools
RUN apt install -y \
    kali-linux-core \
    kali-desktop-core \
    sudo

# Install tools we want
# If you use Kaspersky, you can use http://ftp.riken.jp in the exclusion list.
RUN apt install -y \
    kali-tools-web \
    iputils-ping \
    net-tools \
    kali-tools-vulnerability \
    hydra \
    john \
    metasploit-framework \
    nmap \
    sqlmap \
    wfuzz \
    exploitdb \
    nikto \
    commix \
    hashcat \
    # Wordlists
    wordlists \ 
    cewl \
    seclists

# Install the VSCode
RUN apt install -y wget gpg && \
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg && \
    sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    rm -f packages.microsoft.gpg && \
    apt install -y apt-transport-https && \
    apt update -y && \
    apt install -y code

# Default credential is kali:kali
RUN groupadd -g 1000 kali && \
    useradd -m -s /bin/bash -u 1000 -g 1000 -G sudo kali && \
    echo kali:kali | chpasswd && \
    echo "kali   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Change the WorkDIR
USER kali
WORKDIR /home/kali

# Setup the Japanese language
RUN sudo apt install -y locales-all task-japanese task-japanese-desktop && \
    sudo sed -i 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/g' /etc/locale.gen && \
    sudo dpkg-reconfigure --frontend noninteractive locales && \
    sudo update-locale LANG=ja_JP.UTF-8 && \
    sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Setup the RDP
RUN sudo apt install -y \
    xrdp \
    kali-desktop-gnome \
    x11vnc \
    xvfb \
    novnc \
    dbus-x11

# Setup the VPN
RUN sudo apt install -y openvpn