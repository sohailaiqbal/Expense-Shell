log_file=/tmp/expense.log

Head() {
  echo -e "\e[33m$1\e[0m"
}

App_Prereq() {
 DIR=$1
Head "DELETING EXITING APP CONTENT"
rm -rf $1 &>>$log_file
echo $?

Head "CREATING APPLICATION DIRECTORY"
mkdir $1 &>>$log_file
echo $?

Head "DOWNLOADING APPLICATION CONTENT"
curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>/tmp/expense.log
echo $?

cd /$1
echo $?

Head "EXTRACTING APPLICATION CONTENT"
unzip /tmp/${component}.zip &>>$log_file
echo $?
}