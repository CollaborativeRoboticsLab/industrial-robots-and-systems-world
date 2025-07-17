FROM ubuntu:jammy AS base

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends git \
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
                                                python3 \
                                                python3-venv \
                                                python3-dev \
                                                python3-pip

RUN python3 -m pip install --upgrade pip setuptools wheel

RUN python3 -m pip install  --no-cache-dir  wxPython \
                                            lxml \
                                            future \
                                            matplotlib \
                                            zeroconf \
                                            pyserial

# Clone the OpenPLC Runtime repository
RUN git clone https://github.com/CollaborativeRoboticsLab/OpenPLC_Editor.git

#  Set the working directory
WORKDIR /OpenPLC_Editor

# compile matiec
RUN ./install.sh

# Start the OpenPLC Editor
WORKDIR /OpenPLC_Editor/editor

# Start the OpenPLC Editor
ENTRYPOINT [ "./openplc_editor.sh" ]
