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

# Run the Unity executable
CMD ["/world/irs_test.x86_64"]