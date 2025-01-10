#!/bin/bash

source script/jpg_select.sh

if [ -z "$1" ]; then
  uvid="$(cat .uvid.txt)"
else
  uvid="$1"
fi

mkdir temp
cp images/*.jpg temp

img_list=()
while IFS='' read -r line; do img_list+=("$line"); done < <(jpg_select temp "$uvid")
for img in "${img_list[@]}"; do
  rm "$img"
done
train_images=${#img_list[@]}
total=$train_images

img_list=()
while IFS='' read -r line; do img_list+=("$line"); done < <(jpg_select temp "$uvid")
for img in "${img_list[@]}"; do
  rm "$img"
done
test_images=${#img_list[@]}
total=$((total + test_images))

img_list=()
while IFS='' read -r line; do img_list+=("$line"); done < <(jpg_select temp "$1")
for img in "${img_list[@]}"; do
  rm "$img"
done
valid_images=${#img_list[@]}
total=$((total + valid_images))

rm -r temp

echo "$uvid"
echo "$total"
echo "$train_images"
echo "$valid_images"
echo "$test_images"
