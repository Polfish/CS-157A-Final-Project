FROM mysql

ENV MYSQL_DATABASE=finance_tracker \
    MYSQL_ROOT_PASSWORD=example

ADD /SQL-files/release/ /docker-entrypoint-initdb.d/
COPY test.sh /SQL-files/dev/ ./

EXPOSE 3306