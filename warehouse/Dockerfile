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
                                               unzip

# Copy the pre-downloaded release ZIP
COPY IRS_latest.zip /world.zip

# Unzip and clean
RUN unzip /world.zip -d /world && \
    rm /world.zip

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

# Run the Unity executable
CMD ["/world/irs_test.x86_64"]
