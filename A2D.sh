#!/bin/bash

# type (G=Garmin, R=Runkeeper, S=Strava)
sourcesType=$1

# path to sources
sourcesPath=$2

destPath="$(pwd)/out"
mkdir $destPath

function ConvertGarmin(){
  pushd $sourcesPath > /dev/null
  for l in $(csvtool -t ',' col 1,5 activities.csv)
  do
    activityId=$(echo $l| sed 's/,.*//' )
    activityDate=$(echo $l| sed 's/.*,//')
    
    formattedDate=$(date -d "@$(echo $activityDate | sed 's/...$//')" +"%Y%m%d%H%M%S")

    for ext in gpx tcx
    do
      cp -f ${sourcesPath}$activityId.${ext} ${destPath}/${formattedDate}_Garmin.${ext} > /dev/null 2>&1
    done
    ext=fit
    cp -f ${sourcesPath}$activityId.${ext} ${destPath}/${formattedDate}_Garmin.${ext} > /dev/null 2>&1
  done
  popd $sourcesPath > /dev/null
}


case $sourcesType in
  G)
    ConvertGarmin
    ;;
  R)
    echo "Not implemented"
    ;;
  S)
    echo "Not implemented"
    ;;
  *)
    echo "Not implemented"
    ;;
esac

