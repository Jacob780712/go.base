#!/bin/bash

# This script helps you to cross-compile the service.
# It can be executed either in the current directory or in the root directory of the project make build.

# Support for executing . /build.sh or make build in the project root directory.
if [ -d "../cmd" ]; then
  build_dir=$(cd ./ && pwd)
  cmd_dir=$(cd ./cmd && pwd)
elif [ -d "../cmd" ]; then
  build_dir=$(cd ../ && pwd)
  cmd_dir=$(cd ../cmd && pwd)
else
  echo "The cmd directory could not be found."
  exit 1
fi
#
## Support cross-compiling for Linux, Windows, MacOs
## Iterate through all services in the cmd directory in the project directory,
## compile them, and place the compiled files in the project directory build.
#echo "********** START COMPILING ********** "
#for dir in ${cmd_dir}/*/ ; do
#  cd "${dir}"
#
#  dir_name=$(basename "${dir}")
#
#  echo "${dir_name}"
#
#  if [ ! -d "${build_dir}/build/releases" ]; then
#      mkdir "${build_dir}/build/releases"
#  fi
#
#  # Start the build and clear the previously compiled files if they exist in the build directory.
#  if [ -d "${build_dir}/build/releases/${dir_name}" ]; then
#    rm -rf ${build_dir}/build/releases/${dir_name}
#  fi
#
#  if [ -d "${dir_name}" ]; then
#    rm -r "${dir_name}"
#  fi
#
#  # Perform cross-compilation.
#  GOOS=linux GOARCH=amd64 go build -o ./${dir_name}/${dir_name}-Linux-x86_64 .
#  GOOS=windows GOARCH=amd64 go build -o ./${dir_name}/${dir_name}-Windows-x86_64.exe .
#  GOOS=darwin GOARCH=amd64 go build -o ./${dir_name}/${dir_name}-Darwin-x86_64 .
#
#  # Move to the build directory.
#  mv ${dir_name} ${build_dir}/build/releases/
#  cd ..
#done

echo "********** COMPLETED **************** "

