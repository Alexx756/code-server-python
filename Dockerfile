FROM lscr.io/linuxserver/code-server:latest

USER root

RUN apt-get update && \
    apt-get install -y \
    python3 python3-pip python3-venv \
    build-essential \
    libffi-dev libssl-dev \
    udev screen minicom iputils-ping \
    libusb-1.0-0-dev \
    git clangd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Установка esptool глобально
RUN pip3 install --no-cache-dir esptool

# Даем права пользователю abc на работу с USB (важно для TrueNAS!)
RUN usermod -aG dialout abc && \
    usermod -aG plugdev abc

USER abc

LABEL org.opencontainers.image.source="https://github.com/Alexx756/code-server-python"
