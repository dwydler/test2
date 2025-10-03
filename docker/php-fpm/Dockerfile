# Reference image
FROM php:8.4.13-fpm

# Metadata
LABEL org.opencontainers.image.authors="Daniel Wydler"

# Package lists reread and updated
##RUN apt-get update

# Install package(s)
#RUN apt-get update && apt-get install -y net-tools host mtr iputils-ping traceroute
RUN apt-get update && \
    apt-get install -y \
    net-tools \
    host mtr iputils-ping traceroute locales \
    && rm -r /var/lib/apt/lists/*
    
#RUN apt-get install -y locales 
RUN docker-php-ext-install gettext

# Deletes the already downloaded installation files from the package cache
#RUN apt-get clean

# Remove the package lists
#RUN rm -r /var/lib/apt/lists/*



    
#RUN docker-php-ext-install gettext

# Configure Locale for language detection in the webapp
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

