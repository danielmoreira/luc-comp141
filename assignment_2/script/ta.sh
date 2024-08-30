#!/bin/bash

# parameter
# $1: key to serve as the basis for the computation of the number of files; use UVID

source script/file_count.sh

total_images=0
total_images=$((total_images + $(file_count "$1" 1))) # folder_01
total_images=$((total_images + $(file_count "$1" 2))) # folder_01/folder_02
total_images=$((total_images + $(file_count "$1" 3))) # folder_01/folder_03
total_images=$((total_images + $(file_count "$1" 4))) # folder_01/folder_04
total_images=$((total_images + $(file_count "$1" 5))) # folder_01/folder_03/folder_05
total_images=$((total_images + $(file_count "$1" 6))) # folder_01/folder_03/folder_06

echo "$1"
echo "folder count: 6"
echo "image count: $total_images"
