#!/bin/bash

##############
# Script to prepare the local file system (install resources)
# for the application of Assignment #2 (COMP 141).

# parameter
# $1: key to serve as the basis for the computation of the number of files; use UVID

# usage example:
# ./install.sh dmoreira1
##############

echo "Creating directories for $1."
./script/create_tree.sh "$1"
echo "Directories successfully created at $HOME/comp141_assign2."
