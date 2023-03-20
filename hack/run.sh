#!/bin/bash

# Check if a parameter is passed in
if [ $# -ne 1 ]; then
  echo "How to use: $0 <Catalog Name>"
  exit 1
fi

# Get the first parameter and build the Go file path
dir_name=$1
go_file="../cmd/${dir_name}/main.go"

# Check if the file exists
if [ ! -f "$go_file" ]; then
  echo "File $go_file Does not exist..."
  exit 1
fi

# Executing...
go run "$go_file" run
