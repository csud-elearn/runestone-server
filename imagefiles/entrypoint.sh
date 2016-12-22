#!/bin/bash

#
# Either create or build and then (optionally) serve content

USER_ID=${LOCAL_USER_ID:-9001}

export RS_PASSWORD=${RS_PASSWORD:-"changeme"}
export RS_HOST=${RS_HOST:-"0.0.0.0"}
export RS_PORT=${RS_PORT:-"8000"}

export DB_KIND=${DB_KIND:-sqlite}
export DB_PGSQL_DB=${DB_PGSQL_DB:-runestone}
export DB_PGSQL_USER=${DB_PGSQL_USER:-username}
export DB_PGSQL_PASSWORD=${DB_PGSQL_PASSWORD:-password}
export DB_PGSQL_HOST=${DB_PGSQL_HOST:-0.0.0.0}

export DB_SQLITE_FILE=${DB_SQLITE_FILE:-"/run/storage.sqlite"}

if [ "$DB_KIND" == "sqlite" ]; then
  export DB_URI="sqlite://$DB_SQLITE_FILE"
else
  if [ "$#" -eq 1 ]; then
    export DBNAME=$1
    if psql -lqt | cut -d \| -f 1 | grep -qw $DBNAME ; then
        echo "Database $DBNAME exists"
    else
        echo "Database $DBNAME does not exist..."
        createdb --owner=<yournamehere> runestone
    fi
  fi
fi

#
# If no user specified, dump out the script that
# simplified setting the user
#
if [ "$USER_ID" -eq 9001 ]; then
   cat /opt/runestone-server | tr -d '\015'
else
   echo "Starting with UID : $USER_ID"
   useradd --shell /bin/bash -d /opt -u $USER_ID -o -c "" -m user > /dev/null 2> /dev/null
   export HOME=/opt

   mkdir -p /run
   cd /run ; chown -R user . 
   cd /opt ; chown -R user .

   cd /opt/web2py
   python web2py.py --ip $RS_HOST --port $RS_PORT --password $RS_PASSWORD
fi


