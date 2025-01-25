#!/bin/bash

# Script to create the directory tree and copy the files needed for the
# application of Assignment #2 (COMP 141).

# parameter
# $1: key to serve as the basis for the computation of the number of files; use UVID

# auxiliary functions
# returns the number of files to copy to a folder
source script/file_count.sh

# populates the given folder with files
# returns the number of added images
#
# parameters:
# $1: folder to add files
# $2: folder of the images to be added
# $3: number of images to add (for sure)
# $4: folder of the non-image files to be added
# $5: number of non-image files **to try** to add
#
# In this assignment, we care only about the number of images!
add_files() {
  # function parameters
  folder=$1
  image_folder=$2
  image_count=$3
  file_folder=$4
  file_count=$5

  # count the number of added images
  added_images=0

  # move random images to the folder up to $image_count
  for ((i = 0; i < image_count; i++)); do
    rnd_image=$(find "$image_folder" -type f ! -name "*.txt" | sort -R | head -n 1)
    mv "$rnd_image" "$folder"

    added_images=$((added_images + 1))
  done

  # copy non-image files at random; it may not copy up to $file_count
  for ((i = 0; i < file_count; i++)); do
    rnd_file=$(find "$file_folder" -type f ! -name "*.txt" | sort -R | head -n 1)
    cp "$rnd_file" "$folder"
  done

  # return the number of added images
  echo $added_images
}

# initial folder
pwd_folder=$(pwd)

# holds the number of images, which will be target of the assignment
total_images=0

# saves the given key to compute the number of images for further reference
echo "$1" >.uvid.txt

# Step 1.
# create the basis folder (comp141_assign2) within $HOME
cd "$HOME" || (
  echo "[ERROR 01] Contact instructor."
  exit
)
mkdir -p comp141_assign2
rm -rf comp141_assign2/*
cd comp141_assign2 || (
  echo "[ERROR 02] Contact instructor."
  exit
)

# Step 2.
# create the following static structure of folders:
# comp141_assign2
# └── folder_01
#     ├── folder_02
#     ├── folder_03
#     │   ├── folder_05
#     │   └── folder_06
#     └── folder_04
mkdir -p folder_01/folder_02 folder_01/folder_03/folder_05 folder_01/folder_03/folder_06 folder_01/folder_04

# Step 3.
# add images to folder_01
folder="folder_01"
image_count=$(file_count "$1" 1)
file_count=$(file_count "$1" 12)
current_images=$(add_files $folder "$pwd_folder/data/images" "$image_count" "$pwd_folder/data/json" "$file_count")
total_images=$((total_images + current_images))

# Step 4.
# add images to folder_02
folder="folder_01/folder_02/"
image_count=$(file_count "$1" 2)
file_count=$(file_count "$1" 11)
current_images=$(add_files $folder "$pwd_folder/data/images" "$image_count" "$pwd_folder/data/json" "$file_count")
total_images=$((total_images + current_images))

# Step 5.
# add images to folder_03
folder="folder_01/folder_03"
image_count=$(file_count "$1" 3)
file_count=$(file_count "$1" 10)
current_images=$(add_files $folder "$pwd_folder/data/images" "$image_count" "$pwd_folder/data/json" "$file_count")
total_images=$((total_images + current_images))

# Step 6.
# add images to folder_04
folder="folder_01/folder_04"
image_count=$(file_count "$1" 4)
file_count=$(file_count "$1" 9)
current_images=$(add_files $folder "$pwd_folder/data/images" "$image_count" "$pwd_folder/data/json" "$file_count")
total_images=$((total_images + current_images))

# Step 7.
# add images to folder_05
folder="folder_01/folder_03/folder_05"
image_count=$(file_count "$1" 5)
file_count=$(file_count "$1" 8)
current_images=$(add_files $folder "$pwd_folder/data/images" "$image_count" "$pwd_folder/data/json" "$file_count")
total_images=$((total_images + current_images))

# Step 8.
# add images to folder_06
folder="folder_01/folder_03/folder_06"
image_count=$(file_count "$1" 6)
file_count=$(file_count "$1" 7)
current_images=$(add_files $folder "$pwd_folder/data/images" "$image_count" "$pwd_folder/data/json" "$file_count")
total_images=$((total_images + current_images))

# Last Step.
# copy the moved images back to the images folder
find "folder_01" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.tiff" \) -exec cp {} "$pwd_folder/data/images/" \;

# return to the original folder
cd "$pwd_folder" || (
  echo "[ERROR 03] Contact instructor."
  exit
)
