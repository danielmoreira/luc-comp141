#!/bin/bash

if [ -z "$1" ]; then
  uvid="$(cat .uvid.txt)"
else
  uvid="$1"
fi

code=0
for ((i = 0; i < ${#uvid}; i++)); do
  ascii=$(printf "%d" "'${uvid:$i:1}")
  code=$((code + ascii * 7))
done

echo "$uvid"
echo "$code"
