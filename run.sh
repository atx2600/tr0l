#!/bin/bash

SOCKET="/tmp/tr0l"

case $1 in
	"start" )
		cd ~/.irssi/scripts
		git fetch origin
		git merge origin/master
		tmux -S $SOCKET new -d irssi
	;;

	"stop" )
		tmux -S $SOCKET kill-server
	;;

	"restart" )
		~/run.sh stop
	 	~/run.sh start
	;;
esac
