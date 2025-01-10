#!/bin/bash

##############
# Script to prepare the local file system for the
# application of Assignment #4 (COMP 141).

# usage example:
# ./prepare.sh
##############

echo "Copying program to your home directory."
mkdir -p $HOME/comp141_assign4
rm -rf $HOME/comp141_assign4/*
cp ./script/vir.sh $HOME/comp141_assign4/vir.sh
chmod a-x $HOME/comp141_assign4/vir.sh
echo "Program successfully copied to $HOME/comp141_assign4/"
