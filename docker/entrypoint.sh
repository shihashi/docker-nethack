#!/bin/bash

bonesstoredir="/bones"
bonesgamedir="/nethack/games/lib/nethackdir/"

pass=0

for opt in "$@"
do
    if [[ $pass -eq 0 ]]; then
        case $opt in
            --timezone)
                if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                    echo "command line error: --timezone $2"
                    exit 1
                fi
                timezone="$2"
                shift 2
                pass=1
                ;;
            *)
                nethackargs+=("$1")
                shift 1
                ;;
        esac
    else
        pass=0
    fi
done

if [[ -v timezone ]]; then
    tzfile="/usr/share/zoneinfo/$timezone"
    if [[ ! -f $tzfile ]]; then
        echo "timezone error: $timezone"
        exit 1
    fi
    ln -s $tzfile /etc/localtime
elif [[ -f /localtime ]]; then
    ln -s /localtime /etc/localtime
fi

ls $bonesstoredir/bon*.gz >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
    cp $bonesstoredir/bon*.gz $bonesgamedir
    if [[ $? -ne 0 ]]; then
        exit 1
    fi
fi

/nethack/games/nethack "${nethackargs[@]}"

ls $bonesstoredir/bon*.gz >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
    rm -f $bonesstoredir/bon*.gz
fi

ls $bonesgamedir/bon*.gz >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
    cp $bonesgamedir/bon*.gz $bonesstoredir
fi

