#!/bin/bash
mysql -pexample <<EOFMYSQL
source dev-schema.sql;
source data.sql;
source queries.sql;
EOFMYSQL
mysql -pexample finance_tracker_dev < queries.sql > output.csv