#!/bin/bash

# Install nginx if not already installed
apt-get update
apt-get -y install nginx

# Create necessary directories if they don't exist
mkdir -p /data/web_static/{releases/test,shared}

# Create a fake HTML file for testing
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" > /data/web_static/releases/test/index.html

# Create symbolic link /data/web_static/current
rm -rf /data/web_static/current
ln -s /data/web_static/releases/test/ /data/web_static/current

# Give ownership of /data/ folder to ubuntu user and group recursively
chown -R ubuntu:ubuntu /data/

# Configure Nginx to serve content of /data/web_static/current to hbnb_static
server_block="/etc/nginx/sites-available/holberton"
echo "server {
    listen 80;
    server_name _;

    location /hbnb_static {
        alias /data/web_static/current/;
    }
}" > "$server_block"
ln -sf "$server_block" /etc/nginx/sites-enabled/

# Restart Nginx to apply changes
service nginx restart

exit 0

