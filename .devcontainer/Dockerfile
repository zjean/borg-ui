# Development container for Borg Web UI
FROM python:3.10-bullseye

# Install system dependencies and tools
RUN apt-get update && apt-get install -y \
    # Build essentials
    build-essential \
    gcc \
    g++ \
    make \
    pkg-config \
    python3-dev \
    libffi-dev \
    libssl-dev \
    # Borg dependencies
    libacl1-dev \
    liblz4-dev \
    libzstd-dev \
    libxxhash-dev \
    # Redis
    redis-server \
    redis-tools \
    # SSH and network tools
    openssh-client \
    sshfs \
    fuse \
    rsync \
    sshpass \
    curl \
    wget \
    # Development tools
    git \
    vim \
    htop \
    tree \
    ncdu \
    net-tools \
    iputils-ping \
    # Other utilities
    sudo \
    gnupg \
    lsb-release \
    # Cleanup
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22 (latest LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Borg Backup (matching production version)
RUN pip install --no-cache-dir 'borgbackup>=1.4.3,<1.5.0'

# Configure fuse for non-root users
RUN sed -i 's/^#user_allow_other/user_allow_other/' /etc/fuse.conf

# Create necessary directories
RUN mkdir -p /data /backups /var/log/borg /etc/borg && \
    chmod -R 755 /data /backups /var/log/borg /etc/borg

# Verify installations
RUN python --version && \
    node --version && \
    npm --version && \
    borg --version && \
    redis-server --version

# Set Python to unbuffered mode for better logging
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# The vscode user will be created automatically by the devcontainer feature
# We just need to ensure our directories have appropriate permissions
