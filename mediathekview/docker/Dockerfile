# Pull base image
FROM jlesage/baseimage-gui:debian-12-v4.9.0

#
WORKDIR /

# Kopiere Voraussetzungen
COPY /mediathekview/docker/requirements.txt ./

# Set environment variables
ENV APP_NAME="Mediathekview" \
    #APP_VERSION=14.1.0 \
    DOCKER_IMAGE_VERSION=1.0
    
#
ENV USER_ID=0 \
    GROUP_ID=0 \
    TERM=xterm \
    S6_KILL_GRACETIME=8000

# Locale needed for storing files with umlaut
RUN apt-get update && apt-get install -y apt-utils locales \
    && echo en_US.UTF-8 UTF-8 > /etc/locale.gen \
    && locale-gen \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

#
ENV LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LANG=en_US.UTF-8

# Runtime deps
RUN apt-get update && apt-get install -y \
    wget \
	procps \
    vlc \
    flvstreamer \
    ffmpeg \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Maximize only the main/initial window.
COPY /mediathekview/docker/main-window-selection.xml /etc/openbox/main-window-selection.xml


# Define mountable directories.
VOLUME ["/config"] \
    ["/output"]

# Metadata.
LABEL \
      org.label-schema.name="mediathekview" \
      org.label-schema.description="Docker container for Mediathekview" \
      org.label-schema.version=$DOCKER_IMAGE_VERSION \
      org.label-schema.vcs-url="https://github.com/dwydler/MediathekView-Docker" \
      org.label-schema.schema-version="1.0"

# Download and unpack Mediathekview
RUN mkdir -p /opt/MediathekView
RUN wget -q "https://download.mediathekview.de/stabil/MediathekView-$(cat requirements.txt)-linux.tar.gz" -O MediathekView.tar.gz
RUN tar xf MediathekView.tar.gz -C /opt

# Customizing
#ENV JAVAFX_GLX_DISABLE=0
ENV JAVAFX_TMP_DIR=/tmp/openjfx/cache

COPY /mediathekview/docker/90-mediathekview.sh /etc/cont-init.d/90-mediathekview.sh
RUN chmod 755 /etc/cont-init.d/90-mediathekview.sh

# Startscript for application
COPY /mediathekview/docker/startapp.sh /startapp.sh
RUN chmod 755 /startapp.sh
