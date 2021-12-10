# CS-157A-Final-Project
Final Project for CS 157A

# Instructions to run:
1. git clone https://github.com/Polfish/CS-157A-Final-Project
2. docker compose build
3. docker compose up

# Instructions to get into database:
1. docker exec -it cs-157a-final-project-db-1 (the name might be something else check with `docker ps`!) bash
2. mysql -p (password is `example`)
3. Now, you should be in the mysql database!

# Instructions to run example queries:
1. docker exec -it cs-157a-final-project-db-1 (the name might be something else check with `docker ps`!) bash
2. ./test.sh
3. You should be able to see some output.
