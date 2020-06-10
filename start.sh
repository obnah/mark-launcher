#!/bin/bash

export RELX_REPLACE_OS_VARS=true
export MARKVPASS=${MARKVPASS:-default}
export USER=$(id -nu)


# choose ngsrx_build server
local num choice
echo "Please choose the right ngsrx build server allocated to your team."
echo "---   ------------------   ----   -------   ---------"
echo "No.   Server               Disk   Size(G)   Team"
echo "---   ------------------   ----   -------   ---------"
echo " 1    cnrd-ngsrx-build01   /b     493       Murphy"
echo " 2    cnrd-ngsrx-build02   /b     493       Murphy"
echo " 3    cnrd-ngsrx-build03   /b     493       Tao"
echo " 4    cnrd-ngsrx-build04   /b     493       Tao"
echo " 5    cnrd-ngsrx-build05   /b     493       Zengqiang"
echo " 6    cnrd-ngsrx-build06   /b     493       Zengqiang"
echo " 7    cnrd-ngsrx-build07   /b     493       Cliff"
echo " 8    cnrd-ngsrx-build08   /b     493       Cliff"
echo "---   ------------------   ----   -------   ---------"

if [[ -n $S2BEXT_NGSRXBUILD ]]; then
	num=${S2BEXT_NGSRXBUILD: -1}  # <<< Note the damn space.
	echo -n "Type server No.[1..8]($num): "
else
	echo -n "Type server No.[1..8]: "
fi

while true; do
	read -n 1 -s choice
	case $choice in
		[1-8])
			echo $choice
			break
			;;
		'')
			if [[ -n $num ]]; then
				choice=$num
				echo $choice
				break
			fi
			;;
		*)
			;;
	esac
done
export S2BEXT_NGSRXBUILD=cnrd-ngsrx-build0$choice

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
	[[ $? -eq 0 ]] && break
done
