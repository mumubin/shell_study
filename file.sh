#!/bin/bash

filename="sample.md"
if [ -e "$filename" ]; then
  echo "$filename exists as a file"
fi
