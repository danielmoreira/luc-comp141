#!/bin/bash

##############
# Script to prepare the local file system for the
# application of Assignment #5 (COMP 141).

# usage example:
# ./prepare.sh
##############

echo "Copying program to your home directory."
mkdir -p $HOME/comp141_assign5
rm -rf $HOME/comp141_assign5/*
cp *.csv $HOME/comp141_assign5/
echo "Files successfully copied to $HOME/comp141_assign5/"
