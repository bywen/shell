#!/bin/bash
function ergodic(){
for file in ` ls $1 `
do
    if [ -d $1"/"$file ]
    then
        ergodic $1"/"$file
    else
        local path=$1"/"$file
        local name=$file
         /usr/local/bin/magick $path -resize 50% $path
    fi
done
}
INIT_PATH="/data/wwwroot/mrcba/public/uploads/xcx/"
ergodic $INIT_PATH
~                 
