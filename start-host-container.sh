#!/bin/sh
# This script is responsible for creating a
# host container for anisble and AWS CLI

help() {
    echo "This script is responsible for creating a host container for Anisble and AWS CLI."
    echo "If the container, volume or image already exists, they will not be rebuilt."
    echo "Options:"
    echo "  -b      Rebuilds entire container including image and volume."
}

volume_name="cloud_computing_volume"
image_name="cloud_computing_host_image"
container_name="cloud_computing_host_container"

if getopts "b" flag; then
    podman kill $container_name
    podman rm $container_name
    podman rmi $image_name
    podman volume rm $volume_name
fi

# Create a volume
if podman volume ls | grep -q $volume_name; then
    echo "Volume exists"
else
    echo "Volume does not exist, creating..."
    podman volume create $volume_name
fi

# Build image
if podman image ls | grep -q $image_name; then
    echo "Image exists"
else
    podman build . --tag $image_name
fi

# Run container
if podman ps | grep -q $container_name; then
    echo "Container already running..."
elif podman ps -a | grep -q $container_name; then
    podman start $container_name
    echo "Starting container..."
else
    podman run -itd --name=$container_name --env-file ./.env $image_name
    echo "Running container..."
fi
