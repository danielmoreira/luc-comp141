#!/bin/bash

##############
# Script to prepare the local file system for the
# application of Assignment #3 (COMP 141).

# parameter
# $1: key to serve as the basis for the computation of the number of images to copy around; use UVID

# usage example:
# ./install.sh dmoreira1
##############

echo "Creating directory for $1."
./script/create_folder.sh "$1"
echo "Directory successfully created at $HOME/comp141_assign3."
