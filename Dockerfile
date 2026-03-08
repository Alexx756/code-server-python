FROM lscr.io/linuxserver/code-server:latest

USER root

# 1. Установка системных зависимостей
RUN apt-get update && \
    apt-get install -y \
    python3 python3-pip python3-venv \
    build-essential \
    libffi-dev libssl-dev \
    udev screen minicom iputils-ping \
    libusb-1.0-0-dev \
    git clangd socat gdb-multiarch curl \
    htop ncdu jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 2. Установка esptool (с обходом защиты системных пакетов PEP 668)
RUN pip3 install --no-cache-dir esptool --break-system-packages

# 3. Настройка прав доступа для USB (важно для TrueNAS /dev/ttyACM0)
RUN usermod -aG dialout abc && \
    usermod -aG plugdev abc

# 4. Установка правил udev для PlatformIO (чтобы девайсы подхватывались сами)
RUN curl -fsSL https://raw.githubusercontent.com | tee /etc/udev/rules.d/99-platformio-udev.rules

USER abc

# Метка для связи с твоим репозиторием на GitHub
LABEL org.opencontainers.image.source="https://github.com/Alexx756/code-server-python"
