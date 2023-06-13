# is MacOS ARM
FROM  kalilinux/kali-rolling:arm64

ENV LANG=ja_JP.UTF-8

# Get the latest everything
RUN apt -y update && \
    apt -y upgrade && \
    apt install -y \
    kali-linux-core \
    kali-desktop-core \
    kali-linux-default \
    sudo \
    # Install tools we want
    # If you use Kaspersky, you can use http://ftp.riken.jp in the exclusion list.
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
    seclists \
    # VPN
    openvpn

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
    kali-desktop-xfce \
    x11vnc xvfb novnc\
    dbus-x11

RUN echo "export DISPLAY=:1 \n\
Xvfb :1 -screen 0 1920x1080x24 &\n\
startxfce4 & x11vnc -display :1 -xkb -forever -shared -repeat -listen 0.0.0.0 -nopw -reopen" >> /home/kali/rdesktop.sh && chmod +x /home/kali/rdesktop.sh

# Setup the dotfiles
# TODO: dotfilesのgitをcloneする