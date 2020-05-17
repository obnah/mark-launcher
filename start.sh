#!/bin/bash

export RELX_REPLACE_OS_VARS=true
export MARKVPASS=default


if [[ $MARKVPASS == default ]] ; then
	echo "You are using default password, type Enter to continue with default password or the password you'd like. CTRL+C to break."
	read -s pswd
	case $pswd in
		"" )
			echo "using default password!"
			;;
		* )
			export MARKVPASS=$pswd
			;;
	esac
fi

while true
do
	~aaronhan/share/markV_release.run
	[[ $? -ne 666 ]] && break
done

