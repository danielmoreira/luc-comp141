#!/bin/bash

# Script to create the folder and copy the JPG images needed for the
# application of Assignment #3 (COMP 141).

# parameter
# $1: key to serve as the basis for the computation of the number of images to copy around; use UVID

# auxiliary function
# returns a subset of JPG images stored within a given folder
source script/jpg_select.sh

# initial folder; script will start and end here
pwd_folder=$(pwd)

# saves the given key for further reference
echo "$1" >.uvid.txt

# Step 1.
# create and prepare the basis folder (comp141_assign3) within $HOME,
# as well as its "images" and "temp" inner directory
cd "$HOME" || (
  echo "[ERROR 01] Contact instructor."
  exit
)
mkdir -p comp141_assign3
rm -rf comp141_assign3/*
cd comp141_assign3 || (
  echo "[ERROR 02] Contact instructor."
  exit
)
mkdir images temp
cp "$pwd_folder"/images/*.jpg temp

# Step 2.
# move the JPG images of the "train partition" of the assignment to the "images" folder
call_count=1
img_list=()
while IFS='' read -r line; do img_list+=("$line"); done < <(jpg_select temp "$1" $call_count)
for img in "${img_list[@]}"; do
  img_name=$(echo "$img" | cut -c 6-18)
  mv "$img" 'images/'"$img_name"'train.jpg'
done

# Step 3.
# move the JPG images of the "test partition" of the assignment to the "images" folder
call_count=$((call_count + 1))
img_list=()
while IFS='' read -r line; do img_list+=("$line"); done < <(jpg_select temp "$1" $call_count)
for img in "${img_list[@]}"; do
  img_name=$(echo "$img" | cut -c 6-18)
  mv "$img" 'images/'"$img_name"'test.jpg'
done

# Step 4.
# move the JPG images of the "validation partition" of the assignment to the "images" folder
call_count=$((call_count + 1))
img_list=()
while IFS='' read -r line; do img_list+=("$line"); done < <(jpg_select temp "$1" $call_count)
for img in "${img_list[@]}"; do
  img_name=$(echo "$img" | cut -c 6-18)
  mv "$img" 'images/'"$img_name"'valid.jpg'
done

# Last Step.
# remove the temp folder and return the original one
rm -r temp
cd "$pwd_folder" || (
  echo "[ERROR 03] Contact instructor."
  exit
)
