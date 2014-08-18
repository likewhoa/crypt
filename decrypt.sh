#!/bin/bash
IFS='
'
if [[ $1 == "" ]]
then
    echo "Use: decryptdir [directory]"
    exit
else
[ -x $1 ] && busc=1
if [[ $busc == 1 ]]
then
echo "Directory to Encrypt... ¡Found!"
else
echo -e "Directory to Encrypt... ¡Not Found!"
exit
fi
busc=0
    echo "$1 will be decrypted"
fi

stty -echo
echo -n "Password: "
read passwd
stty echo
echo

for file in `find $1 -type 'f'|grep -E "\.crypted$"`;
    do
        dest=`echo $file|sed -e 's/\.crypted$//'`
        if [ "$dest" != "$file" ]; then
            echo -n "Decrypting $file to $dest... "
            if ( cat "$file"|mdecrypt -q -k $passwd > "$dest" ); then
                echo " OK!"
                echo " Deleting $file"
                if ( rm -f  "$file" ); then
                    echo "OK!"
                else
                    echo "Error!"
                fi
            else
                echo " Error!"
            fi
        fi
    done
