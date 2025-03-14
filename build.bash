#!/bin/bash

# Set the name of the builder
BUILDER_NAME="turtlebuilder"

# Check if the builder already exists
if docker buildx inspect "$BUILDER_NAME" > /dev/null 2>&1; then
    echo "Builder '$BUILDER_NAME' already exists."
else
    echo "Builder '$BUILDER_NAME' does not exist. Creating a new one..."
    
    # Create a new builder with the docker-container driver
    docker buildx create --name "$BUILDER_NAME" --use --driver docker-container
    
    # Inspect the newly created builder
    docker buildx inspect --bootstrap "$BUILDER_NAME"
    
    echo "Builder '$BUILDER_NAME' created and set as the active builder."
fi
docker compose build turtlebot3-arm64 turtlebot3-x64 --progress=plain
docker compose up -d turtlebot3-arm64 turtlebot3-x64
docker compose cp turtlebot3-arm64:/deb/ ./deb-arm64
docker compose cp turtlebot3-x64:/deb/ ./deb-x64
docker compose down
# TODO: zip to create files?
