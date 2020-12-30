#!/bin/bash
## https://www.fiverr.com/papashok
ARG="$1"

# print usage if no agument passed
if [[ -z "$ARG" ]];then
	echo "Usage: bash $0 [ NUMBER ] or [ ROMAN ]"
	echo "Example: bash $0 2018"
	echo "Example: bash $0 MCMXCVIII"
	exit 1
fi
to_roman() {
    local VALUES=( 1000 900 500 400 100 90 50 40 10 5 4 1 )
    # 1990 is rendered as   MCMXC     (1000 = M,   900 = CM,   90 = XC)
    local R_VALUES=(
        [1000]=M [900]=CM [500]=D [400]=CD 
         [100]=C  [90]=XC  [50]=L  [40]=XL 
          [10]=X   [9]=IX   [5]=V   [4]=IV   
           [1]=I
    )
    local INUM=""
    local NUM=$1
    # loop from Array VALUES 1000 to 1
    for VAL in ${VALUES[@]}; do
        while (( NUM >= VAL )); do
            INUM+=${R_VALUES[VAL]}
            ((NUM -= VAL))
        done
    done
    echo $INUM
}

to_decimal() {
  local ROMAN=$1
  local INUM=0
  local PREV=0
 
  for ((i=${#ROMAN}-1;i>=0;i--));do
    case "${ROMAN:$i:1}" in
    M)  VAL=1000 ;;
    D)  VAL=500 ;;
    C)  VAL=100 ;;
    L)  VAL=50 ;;
    X)  VAL=10 ;;
    V)  VAL=5 ;;
    I)  VAL=1 ;;
    esac
 
    if [[ $VAL -lt $PREV ]]
    then
       let INUM-=VAL
    else
       let INUM+=VAL
    fi
 
    PREV=$VAL
  done
 
  echo "$INUM"
}

# Check Argument decimal number
if [[ "$ARG" =~ ^[0-9]+$ ]];then
	NUM=$ARG
	to_roman "$NUM"
else
	ROMAN=$ARG
	# check only contains valid roman characters
	if [[ "${ROMAN//[IVXLCDM]/}" != "" ]];then
		echo "Roman numerals $ROMAN contains invalid characters"
		exit 2
	fi
	to_decimal "$ROMAN"

fi
