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
RUN mkdir /shared_folder

VOLUME /shared_folder

# setup docker
RUN ./install.sh docker \
    && touch /shared_folder/mbconfig.cfg \
    && touch /shared_folder/persistent.file \
    && mkdir /shared_folder/st_files \
    && cp /OpenPLC_v3/webserver/openplc.db /shared_folder/openplc.db \
    && mv /OpenPLC_v3/webserver/openplc.db /OpenPLC_v3/webserver/openplc_default.db \
    && cp /OpenPLC_v3/webserver/dnp3.cfg /shared_folder/dnp3.cfg \
    && mv /OpenPLC_v3/webserver/dnp3.cfg /OpenPLC_v3/webserver/dnp3_default.cfg \
    && cp -r /OpenPLC_v3/webserver/st_files/ /shared_folder/st_files/ \
    && mv /OpenPLC_v3/webserver/st_files /OpenPLC_v3/webserver/st_files_default \
    && cp /OpenPLC_v3/webserver/active_program /shared_folder/active_program \
    && mv /OpenPLC_v3/webserver/active_program /OpenPLC_v3/webserver/active_program_default \
    && ln -s /shared_folder/mbconfig.cfg /OpenPLC_v3/webserver/mbconfig.cfg \
    && ln -s /shared_folder/persistent.file /OpenPLC_v3/webserver/persistent.file \
    && ln -s /shared_folder/openplc.db /OpenPLC_v3/webserver/openplc.db \
    && ln -s /shared_folder/dnp3.cfg /OpenPLC_v3/webserver/dnp3.cfg \
    && ln -s /shared_folder/st_files /OpenPLC_v3/webserver/st_files \
    && ln -s /shared_folder/active_program /OpenPLC_v3/webserver/active_program

# Set the entrypoint
ENTRYPOINT ["./start_openplc.sh"]