#!/bin/bash

source script/file_count.sh

if [ -z "$1" ]; then
  uvid="$(cat .uvid.txt)"
else
  uvid="$1"
fi

total_images=0
total_images=$((total_images + $(file_count "$uvid" 1))) # folder_01
total_images=$((total_images + $(file_count "$uvid" 2))) # folder_01/folder_02
total_images=$((total_images + $(file_count "$uvid" 3))) # folder_01/folder_03
total_images=$((total_images + $(file_count "$uvid" 4))) # folder_01/folder_04
total_images=$((total_images + $(file_count "$uvid" 5))) # folder_01/folder_03/folder_05
total_images=$((total_images + $(file_count "$uvid" 6))) # folder_01/folder_03/folder_06

echo "$uvid"
echo "folder count: 6"
echo "image count: $total_images"
