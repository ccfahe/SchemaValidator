#!/bin/bash

#Input Arguments
flag=0
SchemaFile=$1
OutputReport="${2:-output.txt}"

#Validate arguments passed and provide help material to user
if [ $# -eq 0 ] && [ $# -ne 1 ] && [ $# -ne 2 ]
  then
    echo "\n++++++++++  PLEASE PASS PROPER ARGUMNTS AS PER BELOW FORMAT +++++++++\n\nsh doSchemaValidation.sh\n\nMandatory Arguments\n\t--Schema Diectory/Schema Filename\n\t--OutPut(Optional)\n\nIf all files are in current directory use \n\t--sh doSchemaValidation.sh <folderName>/<FileName> Output.txt"
    exit 1
fi

#Validate environment varibale is set or not
json -h >/dev/null 2>&1
if [ $? -ne 0 ]; 
then
    echo "Command Failed.Probably one of the below is missing\n1.Install Python 2.7 or 3.3 (not above version)\n2.pip install json-spec\n3.Please set python environemnt variable to proceed"
    exit 1
fi

#validate rules.json file present or not
if [ ! -f "rules.json" ];
then
    echo "rules.json file missing"
    exit 1
fi

#Validate if input is a file or folder
if [ -f $1 ]
then
    echo "Input entered is a file"
    echo "$1\n++++++++++++++++++++++++++++++++++++++++++++++++ ">Result.txt
    msg=$(json validate --schema-file=rules.json <$1 2>&1);
   
    if [ -z "$msg" ]  #check msg variable is empty ,if empty means no error 
    then
        echo "Validation Successful" >>Result.txt
    else
        echo "Validation Failed" >>Result.txt
        flag=1
    fi
    echo $msg >>Result.txt
 
#for folder
elif [ -d $1 ]
then
    echo "Input entered is a folder"
    #Filter avro schema files
    find $SchemaFile -type f -name "*.avsc" >filesList.txt
    echo  "Final Validation Starts From here\n" >Result.txt
    flag=0
    while read -r line;
    do
    echo "\n">>Result.txt
    echo $line>>Result.txt
    echo "===============================================================">>Result.txt
    msg=$(json validate --schema-file=rules.json <${line} 2>&1);

    #Check if the above command pass or fail and add result in report
    if [ -z "$msg" ]
    then
          echo "Validation Successful" >>Result.txt
    else
          echo "Validation Failed" >>Result.txt
          flag=1
    fi
    echo $msg>>Result.txt
    done < filesList.txt
else
    echo "Invalid file or directory passed"
    exit 1
fi

#Formatting the Result
cat Result.txt|tr '#' '\n' >$OutputReport
rm -rf Result.txt

#Terminate the script if the validation failed and show result in command line
if [ $flag -eq 1 ]
then 
  echo "Validation failed "
  exit 1
else 
  echo "Validation passed"
fi
