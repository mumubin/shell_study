#!/bin/bash

PRICE_PER_APPLE=5
MyFirstLetter=ABC
greeting='Hello        world!'
echo "The price of an Apple today is : \$HK $PRICE_PER_APPLE"
echo "The first 10 letters in the alphabet are ${MyFirstLetter}DEFGHIJ"
echo $greeting" now with spaces: $greeting"
FILELIST=`ls`
echo $FILELIST
FileWithTimeStamp=/tmp/my-dir/file_$(/bin/date +%Y-%m-%d).txt
echo $FileWithTimeStamp

BIRTHDATE="Jan 1, 2000"
Presents=10
BIRTHDAY=`date -d "$date1" +%A`

if [ "$BIRTHDATE" == "Jan 1, 2000" ] ; then
    echo "BIRTHDATE is correct, it is $BIRTHDATE"
else
    echo "BIRTHDATE is incorrect - please retry"
fi
if [ $Presents == 10 ] ; then
    echo "I have received $Presents presents"
else
    echo "Presents is incorrect - please retry"
fi
    echo "I was born on a $BIRTHDAY"
