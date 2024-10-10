# Use the nginxinc/nginx-unprivileged image as the base image
FROM nginxinc/nginx-unprivileged:stable-alpine

WORKDIR /usr/share/nginx/html

# Copy the custom autoindex configuration
COPY autoindex.conf /etc/nginx/conf.d/

# Copy the data from your local 'ents' and 'geo' directories to the container
COPY ents /usr/share/nginx/html/ents
COPY geo /usr/share/nginx/html/geo


# Expose port 8080 since the unprivileged Nginx listens on 8080 by default
EXPOSE 8080
USER nginx

CMD ["nginx", "-g", "daemon off;"]
