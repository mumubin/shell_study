#!/bin/bash
STRING="this is a string"
echo ${#STRING}

POS=1
LENGTH=3
echo${STRING:$POS:$LEN}

AA="to be or not to be"
echo ${AA[@]/be/eat}
echo ${AA[@]//"to be"/}
echo ${AA/%be/be on $(date +%Y-%m-%d)}
