FROM ros:humble-ros-base-jammy AS base

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends libx11-6 \
                                               libxext6 \
                                               libxrender1 \
                                               libxtst6 \
                                               libxi6 \
                                               libgtk-3-0 \
                                               x11-xserver-utils \
                                               ffmpeg \
                                               libsm6 \
                                               unzip \
                                               findutils

# Copy the pre-downloaded release ZIP
COPY IRS_latest.zip /world.zip

# Unzip and clean
RUN unzip /world.zip -d /world && \
    rm /world.zip

# Find the actual simulation binary (irs_*.x86_64), set it executable, and symlink it as /entry
RUN set -e && \
    EXEC_PATH=$(find /world -type f -regex ".*/irs_.*\.x86_64$" | head -n 1) && \
    chmod +x "$EXEC_PATH" && \
    ln -s "$EXEC_PATH" /entry

# Clean up
RUN rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    apt-get clean

#---------------------------------------------------------------------------------------------------------------------------
FROM ros:humble-ros-base-jammy as final

ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

WORKDIR /

COPY --from=base / /

ENTRYPOINT [ "/ros_entrypoint.sh" ]

# Run the detected simulation executable
CMD ["/entry"]

