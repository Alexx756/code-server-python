FROM lscr.io/linuxserver/code-server:latest

USER root

RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER abc

LABEL org.opencontainers.image.source="https://github.com/Alexx756/code-server-python"