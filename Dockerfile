# Use the nginxinc/nginx-unprivileged image as the base image
FROM nginxinc/nginx-unprivileged:stable-alpine

WORKDIR /usr/share/nginx/html

# Copy the custom autoindex configuration
COPY autoindex.conf /etc/nginx/conf.d/

# Copy the data from your local 'ents' and 'geo' directories to the container
COPY ents /usr/share/nginx/html/ents
COPY geo /usr/share/nginx/html/geo

# Temporarily switch to root to create a non-root user with a specific UID and GID
USER root
RUN addgroup -g 10001 nginxgroup && adduser -u 10001 -G nginxgroup -s /bin/sh -D nginxuser

# Ensure the new non-root user has ownership of the necessary directories
RUN chown -R nginxuser:nginxgroup /usr/share/nginx/html

# Expose port 8080 since the unprivileged Nginx listens on 8080 by default
EXPOSE 8080

# Switch to the new non-root user
USER 10001

CMD ["nginx", "-g", "daemon off;"]
