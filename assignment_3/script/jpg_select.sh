#!/bin/bash

# returns a subset of JPG images stored within the given folder
# the images are selected based on a given string key and
# the number of times this routine has been used so far
# parameters:
# $1: folder whose inner JPG images must be selected
# $2: key to serve as the selection seed; suggestion: use UVID
# $3: number of times this routine has been used so far; suggestion: start with 1

jpg_select() {
  # input parameters
  folder=$1
  key=$2
  call_count=$3

  # number of JPG images within the directory
  jpg_total=$(find "$folder" -name '*.jpg' | wc -l)

  # min and max number of JPG images to be selected
  # min: 50% of $jpg_count minus 10%
  # max: 50% of $jpg_count plus 10%
  jpg_min=$((jpg_total / 2 - jpg_total / 10))
  jpg_max=$((jpg_total / 2 + jpg_total / 10))

  # number of images to be selected, between min and max
  seed=0
  for ((i = 0; i < ${#key}; i++)); do
    ascii=$(printf "%d" "'${key:$i:1}")
    seed=$((seed + ascii * call_count))
  done

  range=$((jpg_max - jpg_min + 1))
  jpg_count=$((seed % range + jpg_min))

  jpg_source=()
  while IFS='' read -r line; do jpg_source+=("$line"); done < <(find "$folder" -name '*.jpg' | sort)

  jpg_select=()
  for ((i = 0; i < jpg_count; i++)); do
    rnd_index=$((seed + (seed % (i + 1)) * ((i + 1) * 7)))
    rnd_index=$((rnd_index % jpg_total))
    jpg_select+=("${jpg_source[$rnd_index]}")
  done

  jpq_list=()
  while IFS='' read -r line; do jpq_list+=("$line"); done < <(printf "%s\n" "${jpg_select[@]}" | sort | uniq)
  for jpg in "${jpq_list[@]}"; do
    echo "$jpg"
  done
}
