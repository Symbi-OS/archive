#!/bin/bash

pattern=",$2,"

sum=$(cat $1 | grep $pattern | tr ',' ' ' | awk '{print $3}' | paste -sd+ | bc)
lc=$(cat $1 | grep $pattern | wc -l)
ave=$(echo "scale=9; $sum/$lc" | bc)

echo Average = $ave

 
