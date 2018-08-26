#!/bin/bash

function A {
 echo "A"
}

function B { 
 echo $1
}

function add {
 echo "$(($1 + $2))"
}

A
B "BBBBB"
add 3 5
