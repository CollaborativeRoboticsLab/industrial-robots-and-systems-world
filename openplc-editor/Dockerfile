# ----------------------------------------------------------------------------------------------------
# Stage 1: Build and prepare artifacts
# ----------------------------------------------------------------------------------------------------
FROM ubuntu:jammy AS builder

ENV DEBIAN_FRONTEND=noninteractive
ENV OPENPLC_DIR=/OpenPLC_Editor
ENV VENV_DIR=$OPENPLC_DIR/.venv

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git ca-certificates wget \
    build-essential bison flex autoconf automake make \
    libgtk-3-dev libgl1-mesa-dev libglu1-mesa-dev \
    python3 python3-venv python3-dev python3-pip \
    libxml2-dev libxslt1-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Clone the repo and submodules
RUN git clone https://github.com/CollaborativeRoboticsLab/OpenPLC_Editor.git $OPENPLC_DIR
WORKDIR $OPENPLC_DIR
RUN git submodule update --init --recursive

# Setup Python virtual environment and install only needed packages
RUN python3 -m venv $VENV_DIR && \
    $VENV_DIR/bin/pip install --upgrade pip && \
    $VENV_DIR/bin/pip install \
      wheel jinja2 lxml future matplotlib zeroconf \
      pyserial pypubsub pyro5 attrdict3 wxPython

# Build MATIEC
WORKDIR $OPENPLC_DIR/matiec
RUN autoreconf -i && ./configure && make -s && \
    cp ./iec2c ../editor/arduino/bin/

# ----------------------------------------------------------------------------------------------------
# Stage 2: Minimal runtime with GUI support
# ----------------------------------------------------------------------------------------------------
    
FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive
ENV OPENPLC_DIR=/OpenPLC_Editor
ENV VENV_DIR=$OPENPLC_DIR/.venv

# Install only runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libx11-6 libxext6 libxrender1 libxtst6 libxi6 libgtk-3-0 \
    libgl1-mesa-glx libglu1-mesa libsm6 \
    libxkbcommon-x11-0 x11-xserver-utils \
    python3 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy built artifacts from builder
COPY --from=builder /OpenPLC_Editor /OpenPLC_Editor

# Create launcher
RUN echo '#!/bin/bash' > /OpenPLC_Editor/openplc_editor.sh && \
    echo 'cd "$OPENPLC_DIR"' >> /OpenPLC_Editor/openplc_editor.sh && \
    echo 'if [ -d "./new_editor" ]; then' >> /OpenPLC_Editor/openplc_editor.sh && \
    echo '  rm -Rf editor' >> /OpenPLC_Editor/openplc_editor.sh && \
    echo '  rm -Rf ./matiec/lib' >> /OpenPLC_Editor/openplc_editor.sh && \
    echo '  mv ./new_editor ./editor' >> /OpenPLC_Editor/openplc_editor.sh && \
    echo '  mv ./new_lib ./matiec/lib' >> /OpenPLC_Editor/openplc_editor.sh && \
    echo 'fi' >> /OpenPLC_Editor/openplc_editor.sh && \
    echo 'source "$VENV_DIR/bin/activate"' >> /OpenPLC_Editor/openplc_editor.sh && \
    echo 'export GDK_BACKEND=x11' >> /OpenPLC_Editor/openplc_editor.sh && \
    echo './.venv/bin/python3 ./editor/Beremiz.py' >> /OpenPLC_Editor/openplc_editor.sh && \
    chmod +x /OpenPLC_Editor/openplc_editor.sh

WORKDIR /OpenPLC_Editor/editor
ENTRYPOINT ["../openplc_editor.sh"]
