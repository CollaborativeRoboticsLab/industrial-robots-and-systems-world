FROM ubuntu:jammy AS base

ENV DEBIAN_FRONTEND=noninteractive
ENV OPENPLC_DIR=/OpenPLC_Editor
ENV VENV_DIR=$OPENPLC_DIR/.venv

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        ca-certificates \
        libx11-6 \
        libxext6 \
        libxrender1 \
        libxtst6 \
        libxi6 \
        libgtk-3-0 \
        x11-xserver-utils \
        ffmpeg \
        libsm6 \
        wget \
        build-essential \
        bison \
        flex \
        autoconf \
        automake \
        make \
        libgtk-3-dev \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        python3 \
        python3-venv \
        python3-dev \
        python3-pip \
        libxml2-dev \
        libxslt1-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone the OpenPLC Editor repository
RUN git clone https://github.com/CollaborativeRoboticsLab/OpenPLC_Editor.git

# Initialize submodules
WORKDIR $OPENPLC_DIR
RUN git submodule update --init --recursive

# Set up Python virtual environment and install Python packages
RUN python3 -m venv $VENV_DIR && \
    $VENV_DIR/bin/pip install --upgrade pip && \
    $VENV_DIR/bin/pip install \
        wheel jinja2 lxml future matplotlib zeroconf \
        pyserial pypubsub pyro5 attrdict3 wxPython

# Compile MATIEC
WORKDIR $OPENPLC_DIR/matiec
RUN autoreconf -i && \
    ./configure && \
    make -s && \
    cp ./iec2c ../editor/arduino/bin/

# Create openplc_editor.sh launcher script
WORKDIR $OPENPLC_DIR
RUN echo '#!/bin/bash' > openplc_editor.sh && \
    echo 'cd "$OPENPLC_DIR"' >> openplc_editor.sh && \
    echo 'if [ -d "./new_editor" ]; then' >> openplc_editor.sh && \
    echo '  rm -Rf editor' >> openplc_editor.sh && \
    echo '  rm -Rf ./matiec/lib' >> openplc_editor.sh && \
    echo '  mv ./new_editor ./editor' >> openplc_editor.sh && \
    echo '  mv ./new_lib ./matiec/lib' >> openplc_editor.sh && \
    echo 'fi' >> openplc_editor.sh && \
    echo 'source "$VENV_DIR/bin/activate"' >> openplc_editor.sh && \
    echo 'export GDK_BACKEND=x11' >> openplc_editor.sh && \
    echo './.venv/bin/python3 ./editor/Beremiz.py' >> openplc_editor.sh && \
    chmod +x openplc_editor.sh

# Set working directory and entrypoint
WORKDIR $OPENPLC_DIR/editor
ENTRYPOINT [ "../openplc_editor.sh" ]