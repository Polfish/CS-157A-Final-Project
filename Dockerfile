FROM mysql

ENV MYSQL_DATABASE=finance_tracker \
    MYSQL_ROOT_PASSWORD=example

ADD /SQL-files/release/ /docker-entrypoint-initdb.d/

EXPOSE 3306