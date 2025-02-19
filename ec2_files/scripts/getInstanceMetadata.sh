#!/bin/bash

# Define the metadata keys to fetch
keys=('ami-id'
    'ami-launch-index'
    'ami-manifest-path'
    'hostname'
    'instance-action'
    'instance-id'
    'instance-life-cycle'
    'instance-type'
    'local-hostname'
    'local-ipv4'
    'mac'
    'public-hostname'
    'public-ipv4'
    'reservation-id'
    'security-groups')

# Create the metadata HTML file
METADATA_FILE=/usr/local/apache2/htdocs/metadata.html
echo "" >"$METADATA_FILE"

# Ensure proper permissions
chmod 777 "$METADATA_FILE"

# Obtain EC2 instance metadata token
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
    -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Fetch and append metadata values
for key in "${keys[@]}"; do
    output=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
        "http://169.254.169.254/latest/meta-data/$key")
    echo "<div>$key : $output</div>" >>"$METADATA_FILE"
done

chown httpd /usr/local/apache2/htdocs -R
