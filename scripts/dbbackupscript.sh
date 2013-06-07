#!/bin/bash

PWD=/cronbackup/`date +%Y/%b/%d`
DBFILE=$PWD/databases.txt
MUSER="root"     # USERNAME
MPASS=""      # PASSWORD
GZIP="$(which gzip)"

# No user servicable parts below

mkdir -p $PWD
rm -f $DBFILE
/usr/bin/mysql -u$MUSER -p$MPASS mysql -Ns -e "show databases" > $DBFILE
for i in `cat $DBFILE` ; do mysqldump --opt -u$MUSER -p$MPASS $i | $GZIP -9 > $PWD/$i.sql.gz ; done

