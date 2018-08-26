#!/bin/bash

my_array=(apple banana "Fruit Basket" orange)
new_array[2]=apricot
echo  ${#my_array[@]} 
my_array[4]="carrot"
