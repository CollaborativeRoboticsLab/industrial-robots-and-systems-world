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
                                               wget \
                                               unzip

RUN wget https://ucstaff-my.sharepoint.com/:u:/g/personal/kalana_ratnayakemudiyanselage_canberra_edu_au/EdWBTzu0FPpBrHChZehqxw8BRRqhmNlTlsv9jRrKp4EbeQ?download=1 -O world.zip && \
    unzip /world.zip && \
    rm /world.zip


#############################################################################################################################
#####
#####   Remove workspace source and build files that are not relevent to running the system
#####
#############################################################################################################################

RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /tmp/*
RUN apt-get clean

#---------------------------------------------------------------------------------------------------------------------------
#----
#----   Start final release image
#----
#---------------------------------------------------------------------------------------------------------------------------

FROM ros:humble-ros-base-jammy as final

ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

WORKDIR /

COPY --from=base / /

ENTRYPOINT [ "/ros_entrypoint.sh" ]

# Run the Unity executable
CMD ["/world/irs_test.x86_64"]