#!/bin/bash

# Setup Postgres Database
echo "Starting PostgreSQL service..."
sudo service postgresql start

echo "Creating database: $POSTGRES_DB..."
sudo -u postgres psql -c "CREATE DATABASE $POSTGRES_DB;"

echo "Creating user: $POSTGRES_USER with password: $POSTGRES_PASSWORD..."
sudo -u postgres psql -c "CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';"
sudo -u postgres psql -c "ALTER USER $POSTGRES_USER WITH SUPERUSER;"

echo "Granting privileges to user: $POSTGRES_USER on database: $POSTGRES_DB..."
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;"

echo "PostgreSQL initialized."

# Populate database from SQL scripts
flyway -url=jdbc:postgresql://localhost:5432/${POSTGRES_DB} -user=${POSTGRES_USER} -locations=filesystem:${PROJECT_FOLDER_FULL_PATH}/sql -password=${POSTGRES_PASSWORD} migrate