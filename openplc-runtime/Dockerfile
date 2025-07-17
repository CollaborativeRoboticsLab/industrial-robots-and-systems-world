FROM ubuntu:jammy AS base

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends git \
                                               ca-certificates

# Clone the OpenPLC Runtime repository
RUN git clone https://github.com/thiagoralves/OpenPLC_v3.git

#  Set the working directory
WORKDIR /OpenPLC_v3

# Create a directory for persistent data
RUN mkdir /docker_persistent

VOLUME /docker_persistent

# setup docker
RUN ./install.sh docker \
    && touch /docker_persistent/mbconfig.cfg \
    && touch /docker_persistent/persistent.file \
    && mkdir /docker_persistent/st_files \
    && cp /OpenPLC_v3/webserver/openplc.db /docker_persistent/openplc.db \
    && mv /OpenPLC_v3/webserver/openplc.db /OpenPLC_v3/webserver/openplc_default.db \
    && cp /OpenPLC_v3/webserver/dnp3.cfg /docker_persistent/dnp3.cfg \
    && mv /OpenPLC_v3/webserver/dnp3.cfg /OpenPLC_v3/webserver/dnp3_default.cfg \
    && cp -r /OpenPLC_v3/webserver/st_files/ /docker_persistent/st_files/ \
    && mv /OpenPLC_v3/webserver/st_files /OpenPLC_v3/webserver/st_files_default \
    && cp /OpenPLC_v3/webserver/active_program /docker_persistent/active_program \
    && mv /OpenPLC_v3/webserver/active_program /OpenPLC_v3/webserver/active_program_default \
    && ln -s /docker_persistent/mbconfig.cfg /OpenPLC_v3/webserver/mbconfig.cfg \
    && ln -s /docker_persistent/persistent.file /OpenPLC_v3/webserver/persistent.file \
    && ln -s /docker_persistent/openplc.db /OpenPLC_v3/webserver/openplc.db \
    && ln -s /docker_persistent/dnp3.cfg /OpenPLC_v3/webserver/dnp3.cfg \
    && ln -s /docker_persistent/st_files /OpenPLC_v3/webserver/st_files \
    && ln -s /docker_persistent/active_program /OpenPLC_v3/webserver/active_program

# Set the entrypoint
ENTRYPOINT ["./start_openplc.sh"]