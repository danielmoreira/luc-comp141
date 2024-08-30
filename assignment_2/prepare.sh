#!/bin/bash

##############
# Script to prepare the local file system for the
# application of Assignment #2 (COMP 141).

# parameter
# $1: key to serve as the basis for the computation of the number of files; use UVID

# usage example:
# ./prepare.sh dmoreira1
##############

./script/create_tree.sh "$1"
