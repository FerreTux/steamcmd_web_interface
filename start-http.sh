#!/bin/bash

echo " Steam CMD Http Server Control 1.0 "
echo " @ferretux"
echo "********************************************"

#screen -S flasker -X quit > /dev/null 2>&1

if [ "$1" == "" ];
then
    arg="[NULL]"
else
    arg="$1"
fi

echo "Running command $arg......"

if [ "$arg" == "-kl" ];
then
   echo -e "\n\e[94mListing runing python pids use \e[1;34m'kill -9 [pid]'\e[94m to stop runaway process\e[0m" 
   echo "---------------------------------------------"
   ps -ef | grep python
   echo -e "\n\e[94mListing runing flask pids use \e[1;34m'kill -9 [pid]'\e[94m to stop runaway process\e[0m"
   echo "---------------------------------------------"
   ps -ef | grep flask
   exit 0
fi
if [ "$arg" == "stop" ];
then
    echo -e "\e[31mKilling processes"
    ./stop-http.sh > /dev/null 2>&1
    echo -e "\e[31mAll Proccesses Killed"
    exit 0
fi
if [ "$arg" == "start" ];
then
    echo "Begining Startup..."
    export FLASK_APP="server.py"
    export FLASK_ENV=development
    echo "#!/bin/bash" > stop-http.sh 2>&1 
    flask run -h 10.0.0.168 > log.txt 2>&1 &
    echo "Creating Kill list"
    sleep 2
    ps ef | grep "[f]lask" | awk '{print "kill -9 " $1}' >> stop-http.sh 2>&1 
    echo "Server Output:"
    cat log.txt
    echo -e "\e[34mServer Started!"
else
    echo -e "\e[31mstart-http.sh $arg e{Invalid command}\e[0m"
    echo "--------------------------------------------"
    echo "start-http.sh [command]"
    echo "\nLegal Commands  "
    echo "  start - starts the server in screen"
    echo "  -kl   - list killable pids that could be causing issues"
    echo "  stop  - Stops all flask instances launched"
fi
