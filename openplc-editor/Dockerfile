FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV OPENPLC_DIR=/opt/openplc-editor
ENV ELECTRON_DISABLE_SANDBOX=1
ENV LIBGL_ALWAYS_SOFTWARE=1

# Install Node.js 22 and system dependencies required by Electron and native modules.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        gnupg

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y --no-install-recommends \
        nodejs \
        build-essential \
        python3 \
        xvfb \
        libasound2t64 \
        libatk-bridge2.0-0t64 \
        libatk1.0-0t64 \
        libcups2t64 \
        libdbus-1-3 \
        libdrm2 \
        libgbm1 \
        libglib2.0-0t64 \
        libgtk-3-0t64 \
        libnss3 \
        libnspr4 \
        libx11-6 \
        libx11-xcb1 \
        libxcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxkbcommon0 \
        libxrandr2 \
        libxrender1 \
        libxshmfence1 \
        libxss1 \
        libxtst6 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone the new OpenPLC Editor and install its dependencies.
RUN git clone --depth 1 https://github.com/Autonomy-Logic/openplc-editor.git "$OPENPLC_DIR"

WORKDIR $OPENPLC_DIR
RUN npm install

# Start the Electron app on the host X11 display when available, otherwise fall back to Xvfb.
RUN printf '%s\n' \
    '#!/bin/sh' \
    'set -e' \
    'cd "$OPENPLC_DIR"' \
    'if [ -z "$DISPLAY" ]; then' \
    '  export DISPLAY=:99' \
    '  Xvfb :99 -screen 0 1920x1080x24 >/tmp/xvfb.log 2>&1 &' \
    'fi' \
    'exec npm run dev' \
    > /usr/local/bin/openplc-editor && chmod +x /usr/local/bin/openplc-editor

ENTRYPOINT ["/usr/local/bin/openplc-editor"]