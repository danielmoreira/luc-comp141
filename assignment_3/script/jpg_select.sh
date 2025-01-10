#!/bin/bash

# returns a random subset of JPG images stored within the given folder
# the images are randomly selected based on a given string key,
# which is taken as the seed of the random number generator
# parameters:
# $1: folder whose inner JPG images must be randomly selected
# $2: key to serve as the random number generation seed; suggestion: use UVID
jpg_select() {
  # input parameters
  folder=$1
  key=$2

  # number of JPG images within the directory
  jpg_total=$(find "$folder" -name '*.jpg' | wc -l)

  # min and max number of JPG images to be selected
  # min: 50% of $jpg_count minus 10%
  # max: 50% of $jpg_count plus 10%
  jpg_min=$((jpg_total / 2 - jpg_total / 10))
  jpg_max=$((jpg_total / 2 + jpg_total / 10))

  # random number of images to be selected, between min and max
  seed=0
  for ((i = 0; i < ${#key}; i++)); do
    ascii=$(printf "%d" "'${key:$i:1}")
    seed=$((seed + ascii))
  done

  RANDOM=$seed
  range=$((jpg_max - jpg_min + 1))
  jpg_count=$((RANDOM % range + jpg_min))

  jpg_source=()
  while IFS='' read -r line; do jpg_source+=("$line"); done < <(find "$folder" -name '*.jpg' | sort)

  jpg_select=()
  for ((i = 0; i < jpg_count; i++)); do
    rnd_index=$((RANDOM % jpg_total))
    jpg_select+=("${jpg_source[$rnd_index]}")
  done

  jpq_list=()
  while IFS='' read -r line; do jpq_list+=("$line"); done < <(printf "%s\n" "${jpg_select[@]}" | sort | uniq)
  for jpg in "${jpq_list[@]}"; do
    echo "$jpg"
  done
}
