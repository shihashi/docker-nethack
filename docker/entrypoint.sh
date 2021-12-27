#!/bin/sh

bonesstoredir="/bones"
bonesgamedir="/nethack/games/lib/nethackdir/"

ls $bonesstoredir/bon*.gz >/dev/null 2>&1
if [ $? -eq 0 ]; then
    cp $bonesstoredir/bon*.gz $bonesgamedir
fi

/nethack/games/nethack "$@"

ls $bonesgamedir/bon*.gz >/dev/null 2>&1
if [ $? -eq 0 ]; then
    cp $bonesgamedir/bon*.gz $bonesstoredir
fi

