#!/bin/bash

cd inputs

for f in `ls`
do
    ## word count local machine
    cat $f | ../src/wc/word_count.py > ../outputs/"wc_result_$f"

    ## word count hadoop mapreduce
    # put input files into hdfs
    input_folder="input_$f"
    if ! hadoop fs -test -e $input_folder
	then
	hadoop fs -mkdir $input_folder
	hadoop fs -put $f $input_folder
    fi
    
    # delete output files in hdfs, since hdfs doesn't allow overwrite to existing files
    output_folder="output_$f"
    if hadoop fs -test -e $output_folder
	then
	hadoop fs -rm -r $output_folder
    fi

    # run hadoop mapreduce job
    hadoop jar /usr/lib/hadoop-0.20-mapreduce/contrib/streaming/hadoop-streaming-2.0.0-mr1-cdh4.1.1.jar -mapper ../src/wc/mapper.py -reducer ../src/wc/reducer.py -file ../src/wc/mapper.py -file ../src/wc/reducer.py -input $input_folder -output $output_folder
    
    # copy the output file from hdfs to local machine
    hadoop fs -cat $output_folder/part-00000 > ../outputs/"wc_result_hadoop_$f"

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



