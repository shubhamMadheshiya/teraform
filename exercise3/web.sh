#!/bin/bash

# Install necessary packages
yum install wget unzip httpd -y

# Start and enable the Apache web server
systemctl start httpd
systemctl enable httpd

# Download and unzip the template
wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
unzip -o 2117_infinite_loop.zip

# Copy the unzipped files to the web directory
cp -r 2117_infinite_loop/* /var/www/html/

# Ensure correct permissions for the web files
chown -R apache:apache /var/www/html/

# Restart Apache to apply changes
systemctl restart httpd
