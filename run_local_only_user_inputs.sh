#!/bin/bash

while true
do
    echo "What input folder do you need?"
    read input_folder
    echo "You entered: $input_folder"
    if test -e $input_folder
	then
	echo "continue..."
	break
    else
	echo "folder not exists, try it again"
    fi
done


cd $input_folder

for f in `ls`
do
    ## word count local machine
    cat $f | ../src/wc/word_count.py > ../outputs/"wc_result_$f"

    ## running median
    cat $f | ../src/r_median/running_median.py > ../outputs/"med_result_$f"

done

## running median for multiple files
i=0
for f in `ls`
do 
   arr[i]=$f 
   i=$((i+1))
done

sorted=($(printf '%s\n' "${arr[@]}"|sort))
touch all_in_one

for f in "${sorted[@]}"
do
    cat $f >> all_in_one
done

cat all_in_one | ../src/r_median/running_median.py > ../outputs/med_result_all_in_one
rm -f all_in_one

cd ..



