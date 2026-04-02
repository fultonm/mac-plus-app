# See https://aka.ms/vscode-remote/devcontainer.json for format details
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install standard build tools and M68K toolchain for 68000 assembly/links
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    software-properties-common \
    ca-certificates \
    gnupg \
    dirmngr \
  && add-apt-repository -y universe \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    make \
    git \
    gcc-m68k-linux-gnu \
    binutils-m68k-linux-gnu \
    gdb-multiarch \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
