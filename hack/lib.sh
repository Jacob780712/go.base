#!/bin/bash

# Get version number
get_version() {
  parent_path=$(dirname "$(pwd)")
  version_file="$parent_path/VERSION"
  if [ -f "$version_file" ]; then
    head -n 1 "$version_file"
  else
    echo "Version file not found!"
  fi
}

# List all services
list_cmd_folders() {
  cmd_dir=$(dirname "$(dirname "$(readlink -f "$0")")")/cmd
  for dir in "$cmd_dir"/*; do
    if [ -d "$dir" ]; then
      echo "$(basename "$dir")"
    fi
  done
}

# get system info
get_system_info() {
  echo "************ System Information ************"
  uname -a
  echo ""
  echo "************ CPU Information ************"
  cat /proc/cpuinfo
  echo ""
  echo "************ Memory Information ************"
  cat /proc/meminfo
  echo ""
  echo "************ Hard Drive Information ************"
  df -h
  echo ""
  echo "************ PCI Information ************"
  lspci
  echo ""
  echo "************ USB Information ************"
  lsusb
}
