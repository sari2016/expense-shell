source common.sh
component=backend

echo Install NodeJS Repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &&>>$log_file

stat_check



echo Install NodeJS
dnf install nodejs -y &&>>$log_file
stat_check


    echo copy Backend Service File
cp backend.service /etc/systemd/system/backend.service &&>>$log_file
stat_check

echo Add Application User
useradd expense &&>>$log_file
stat_check

echo Clean App Content
rm -rf /app &&>>$log_file
mkdir /app
stat_check

echo Download App Content

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &&>>$log_file
cd /app
stat_check

echo Extract App Content
unzip /tmp/backend.zip &&>>$log_file

stat_check

echo Download Dependencies
cd /app
npm install &>>$log_file
stat_check

echo Start Backend Service
systemctl daemon-reload &&>>$log_file
systemctl enable backend &&>>$log_file
systemctl start backend &&>>$log_file
stat_check
echo Install MYSQL Client
dnf install mysql -y
