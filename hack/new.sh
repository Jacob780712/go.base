#!/bin/bash

# This script relies on cobra to check if cobra is installed or not.
# Check if cobra is already installed

if command -v cobra-cli &> /dev/null
then
    echo "creating a project with cobra ..."
else
    echo "install cobra-cli ..."
    go install github.com/spf13/cobra-cli@latest
fi


# Create a service
# EXAMPLE: . /new article
# Create the cmd directory if it does not exist, and then go to the cmd directory to initiate the service.

cd ../

if [ ! -d "cmd" ]; then
  mkdir cmd
fi

pkgName=$1

cd ./cmd

if [ ! -d "$pkgName" ]; then
  mkdir "$pkgName"
fi

cd "$pkgName"

echo "service name is $pkgName"

cobra-cli init && cobra-cli add run && ls -R && cd ../../hack
