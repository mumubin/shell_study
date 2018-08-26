#!/bin/bash
numbers=(1,2,3)
numbers[4]="hello"
numbers[5]="world"
echo ${numbers[2]}
echo ${numbers[4]}
