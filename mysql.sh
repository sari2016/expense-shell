source common.sh

echo Disable MYSQL 8 Version

dnf module disable mysql -y &>>$log_file
stat_check

echo Copy MYSQL Repo File
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
stat_check

echo Install MYSQL Server
dnf install mysql-community-server -y &>>$log_file
stat_check

echo Start MYSQL Service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
stat_check

echo Setup root password
mysql_root_password=$1
mysql_secure_installation --set-root-pass $mysql_root_password &>>$log_file
stat_check


