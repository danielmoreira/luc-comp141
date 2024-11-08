#!/bin/bash

##############
# Script to prepare the local file system for the
# application of Assignment #6 (COMP 141).

# usage example:
# ./prepare.sh
##############

echo "Copying program to your home directory."
mkdir -p $HOME/comp141_assign6
rm -rf $HOME/comp141_assign6/*
cp script/data_gen.sh $HOME/comp141_assign6/
echo "Files successfully copied to $HOME/comp141_assign6/"
