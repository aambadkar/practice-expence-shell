log_file=/tmp/expense.log

download_and_extract() {
  echo download $component code
  curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>$log_file
if [ $? -eq 0 ]; then
   echo SUCCESS
else
   echo FAILED
fi

  echo extracting $component code
  unzip /tmp/$component.zip >>$log_file
 if [ $? -eq 0 ]; then
    echo SUCCESS
 else
    echo FAILED
 fi
}