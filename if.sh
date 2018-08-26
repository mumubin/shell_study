NAME="CC"

if [ "$NAME" -lt "AA" ]; then
    echo "I'm AA"
elif [ "$NAME" -gt "CC" ]; then
    echo "I'm CC"
else
    echo "I'm BB"
fi

mycase=1
case $mycase in
    1) echo "You selected bash";;
    2) echo "You selected perl";;
    3) echo "You selected phyton";;
    4) echo "You selected c++";;
    5) exit;;
esac
