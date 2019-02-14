#!/bin/bash
#set directory permissions
cd $path_cwd
dir_name=lambda_pkg_$random_string/
mkdir $dir_name

#virtual env setup
cd $path_module
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
cp -r . $path_cwd/$dir_name
cp -r $source_code_path/ $path_cwd/$dir_name
#removing virtual env folder
rm -rf $path_module/env-$function_name/
#add lambda_pkg directory to .gitignore
GIT_FILE=$path_cwd/.gitignore
if [ -f $GIT_FILE ]; then
  echo '#ignore lambda_pkg dir' >> $path_cwd/.gitignore
  echo $dir_name >> $path_cwd/.gitignore
else
  echo '#ignore lambda_pkg dir' > $path_cwd/.gitignore
  echo $dir_name > $path_cwd/.gitignore
fi
