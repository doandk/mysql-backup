#!/bin/bash

TODAY=`date +"%d%b%Y-%T"`

DUMP_DIR='/data/backup'
MYSQL_HOST='35.247.x.x'
MYSQL_PORT='3306'
MYSQL_USER='admin'
MYSQL_PASSWORD='xxxxxxx'

DB_PREFIX="mydb1 mydb2"

for list in $DB_PREFIX
do
   { mysqldump -h ${MYSQL_HOST} \
   -P ${MYSQL_PORT} \
   -u ${MYSQL_USER} \
   -p${MYSQL_PASSWORD} --databases \
   ${list} > ${DUMP_DIR}${list}-$TODAY.sql ;} 2>> export.log

   if [ $? -eq 0 ]; then
   echo "Database export successfully completed"
   echo "Creating direcory"
   mkdir ${DUMP_DIR}/${list}
   mv ${DUMP_DIR}${list}-$TODAY.sql ${DUMP_DIR}/${list}

   else
   echo "Error found during backup"
   exit 1
   fi
done

# DUMPING with time details
# {time mysqldump -h db-host -P 3306 --user=admin@db-host --password=$password --databases db-name > $backup_path/db-$TODAY.sql ; } 2>> db.log

