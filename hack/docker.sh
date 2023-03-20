#!/bin/bash

docker_build_image() {
  # Find the location of the build folder and set the path to the build_dir variable.
  if [ -d "./build" ]; then
    build_dir=./build
  else
    if [ -d "../build" ]; then
      build_dir=../build
    else
      echo "Unable to find build directory in current or parent directory."
    fi
  fi

  # Define dockerfile variables.
  base_image="ubuntu:latest"
  tmpl="${build_dir}/Dockerfile.template"
  rels_dir=${build_dir}/releases
  workdir="app"
  tag="latest"

  for dir in $(find "${rels_dir}"/* -type d)
  do
    service_name=$(basename "${dir}")
    source_app_dir=${rels_dir}/${service_name}
    output_file="${source_app_dir}/Dockerfile"
    source_service_path=$(basename "$(find "$dir" -name "*Linux*" -print)")

    sed -e "s|{{base_image}}|${base_image}|g" \
        -e "s|{{source_service_path}}|${source_service_path}|g" \
        -e "s|{{workdir}}|${workdir}|g" \
        -e "s|{{service_name}}|${service_name}|g" \
        -e "s|{{command}}|${command}|g" \
        "$tmpl" > "$output_file"

    # When I try to use the specified dockerfile path,
    # COPY does not work when copying files using absolute paths, 
    # so I'll leave the current problem for later.
    # Now set the current path to a variable and return it via that variable
    # after going to the specified dockerfile file to build it.
    current_path=$(pwd)
    # build docker image.
    cd "${source_app_dir}" && sudo docker build -t "${service_name}:${tag}" . && cd "${current_path}"
  done
}

# This script is used to manipulate docker.
# build images (e.g: ./docker build)
# run container (e.g: ./docker run <SERVICE_NAME> <PROT>)
# docker clean image (e.g: ./docker clear)
if [ "$1" = "build" ]; then
  docker
elif [ "$1" = "run" ]; then
  echo "run"
  sudo docker run -d --name "$2" -p "$3":"$3" "$2":latest
elif [ "$1" = "clear" ]; then
  echo "clear"
  docker rm $(docker ps -aqf "status=exited") && docker image prune
else
  echo "Invalid argument"
  echo "run <APP_NAME> <PORT>"
  echo "build"
  echo "clear"
fi