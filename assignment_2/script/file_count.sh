#!/bin/bash

# returns the number of files to copy to a folder
# parameters:
# $1: key to serve as the basis for the number computation; use UVID
# $2: folder number/position
file_count() {
  sum=0
  max_file=5 # max number of files

  # function parameters
  key=$1
  folder=$2

  for ((i = 0; i < ${#key}; i++)); do
    ascii=$(printf "%d" "'${key:$i:1}")
    sum=$((sum + ascii))
  done

  value=$(((sum + folder) * folder % max_file + 1))
  echo $value
}
