#!/bin/bash
#set directory permissions
cd $path_module
mkdir source_code

#virtual env setup
virtualenv -p $runtime env-$function_name
source env-$function_name/bin/activate

#installing python dependencies
FILE=$source_code_path/requirements.txt
if [ -f $FILE ]; then
   echo "requirement.txt file exists in source_code_path. Installing dependencies.."
   pip install -q -r $FILE --upgrade
else
   echo "requirement.txt file does not exist. Skipping installation of dependencies."
fi
#deactivate virtualenv
deactivate
#creating deployment package
cd env-$function_name/lib/$runtime/site-packages/
cp -r . $path_module/source_code/
cp -r $source_code_path/ $path_module/source_code/
#removing virtual env folder
rm -rf $path_module/env-$function_name/
