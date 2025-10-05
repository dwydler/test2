# Reference image
FROM nginx:1.29.1

# Metadata
LABEL org.opencontainers.image.authors="Daniel Wydler"

# Package lists reread and updated 
RUN apt-get update

# Install package(s)
RUN apt-get install -y sqlite3

# Deletes the already downloaded installation files from the package cache
RUN apt-get clean

# Remove the package lists
RUN rm -r /var/lib/apt/lists/*

#
COPY --chmod=755 /docker/nginx/99-lookingglass-config.sh /docker-entrypoint.d/

#
CMD ["nginx", "-g", "daemon off;"]

