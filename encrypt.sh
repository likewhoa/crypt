#!/bin/bash
IFS='
'
if [ -z $1 ]; then 
	echo "Use: cryptdir [directory]"
	exit
else

[ -x $1 ] && busc=1

if [ $busc == 1 ]; then
	echo "Directory to Encrypt... Found!"
else
	echo -e "Directory to Encrypt... Not Found!"
exit
fi
busc=0
    echo "$1 will be encrypted"
fi

echo "Enter Password"; read -rsp "" pwd1
echo "Confirm the password"; read -rsp "" pwd2

if [ "$pwd1" != "$pwd2" ]; then
	echo "Passwords don't match"
	exit
fi

for file in `find $1 -type f|grep -v -E "\.crypted$"`;
    do

        dest="${file}.crypted"
        if [ "$dest" != "$file" ]; then
            echo -n "Encrypting $file a $dest..."
            if ( cat "$file"|mcrypt -a blowfish -q -k $pwd1 > "$dest" ); then
                echo "OK!"
                echo "Deleting $file"
		rm -f "$file" 1&>1 || echo "Error Deleting."
	fi
        else
            echo "$file is encrypted!"
        fi
    done

unset $pwd1
unset $pwd2
