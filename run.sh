#!/bin/bash

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
	
	"attatch" )
		tmux -S $SOCKET att
	;;

	"reload" )
		tmux -S $SOCKET send -t 0 "/SCRIPT load bot" ENTER
esac
