#!/bin/bash

case $1 in
    "update" )
        cd ~/.irssi/scripts
        git fetch origin
        git merge origin/master
        ;;

    "attach" )
        tmux -S $SOCKET att
        ;;

    "reload" )
        tmux -S $SOCKET send "/SCRIPT load bot" ENTER
        ;;

    "start" )
        ~/run.sh update
        tmux -S $SOCKET new -d irssi
        ;;

    "restart" )
        ~/run.sh stop
        ~/run.sh start
        ;;

    "stop" )
        tmux -S $SOCKET kill-server
        ;;

    * )
        echo "tr0l control script"
        echo "  usage run.sh start | stop | restart | update | attach | reload"
esac
