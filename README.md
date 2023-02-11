The schemavalidator tools play a very important role oin validating the schemas.We have lots of tool available online to validate json,avro that validate w.r.t to certain schemas.But these schema are not being validated and left as it is ,that creates non uniformitity in syntax and format.

To avoid non uniformity commmit of schema we have found these tool .These is a very simple tool written in python ,with few steps you cna go head to use it.Further if you want to use a docker container to avoid installing pthon and other dependency ,dockerfile is provided.

If we need to add these code to CICD we can use the jenkinsfile and you can customize accordingly.

Please go head and enjoy using it!


**Step1:Installation**
- 1.Install Python 2.7 or 3.3 not above version from link https://www.python.org/downloads/release/python-2718/
- 2.pip install json-spec
- 3.Set PATH=$PATH:< Python installation Dir >/bin
- 4.Checkout Schema validator tool
- 5.There you GO!

**Docker Approach**
- docker run -d -it -v /<schema folder>:/opt/app/schemas/  <imageName>
- To buid Image and use: docker build -t <imageName>
- To use existing Image: docker pull <imageName>:latest
- To modify and push Image :docker push <imageName>:latest

**Validating multiple Schema**
- sh doSchemaValidation.sh <Directory_Path_Where_All_Schema_Are_Available> <output_file>

**Functionality covered so far**
- Check if enviornment variable set for python
- Check for valid number of arguments and provide suggestion to user 
- Scan the directory and subdirectories for Schemas
- Check for single file or Directory and accordingly proceed for validation
- Filter *avsc files only insid egiven directory
- Validate and Generate report in user defined file else by default uses outpot.txt
- Terminate the script with exit code 1 if validation failed in any of the schema file 


**CICD**
- Jenkins can trigger the bash script with respective arguments
- Jenkins can use the exit code for validation result

""""
- sh doSchemaValidation.sh <schema File> <outpot>
- Validation failed 
- echo $?                                  
- 1

""""
- Before termination the detailed report will be available in a text file for developer to get reference and do correction


**Limitation**
- This package JSON-SCHcan be used by python 2.7, 3.3 and pypi.






