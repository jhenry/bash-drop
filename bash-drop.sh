#!/bin/bash

source $BASHDROP_CONFIG
scpTarget="$scpUser@$scpHost:~/$scpDir"

rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"
}

/usr/local/bin/fswatch --event Created "$watchFolder" | while read filePath ; do 
  fileName=$(basename "$filePath")
  encodedFileName=$(rawurlencode "$fileName")
  url="$publicPath$encodedFileName"

  # Display success notification 
  /usr/bin/osascript -e "display notification \"$fileName\" with title \"Uploading file...\""

  # Upload the file
  #/usr/bin/scp -q -o LogLevel=QUIET "$filePath" "$scpTarget"
  /usr/bin/scp "$filePath" "$scpTarget"

  if [ "$?" -eq "0" ];
  then
    # Send URL-encoded link to the clipboard
    echo "$url" | pbcopy

    # Display success notification 
    /usr/bin/osascript -e "display notification \"$fileName\" with title \"Uploaded and copied URL\""
  else
    # Display failure notification and play a sound
    /usr/bin/osascript -e "display notification \"scp $filePath $scpTarget\" with title \"ERROR: Failed to upload file.\" sound name \"Submarine\"" 
      
  fi

done