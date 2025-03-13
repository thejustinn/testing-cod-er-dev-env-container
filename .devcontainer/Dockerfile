FROM mcr.microsoft.com/vscode/devcontainers/dotnet:9.0-noble

# RUN apt-get update && apt-get upgrade -y && \

RUN apt-get update && \
    apt-get install -y wget gnupg openjdk-17-jre && \
    echo "deb http://apt.postgresql.org/pub/repos/apt noble-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
    wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y postgresql-17 postgresql-client-17 && \
    apt-get clean

RUN mkdir -p /var/run/postgresql && chown -R postgres:postgres /var/run/postgresql

RUN wget -qO- https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/11.4.0/flyway-commandline-11.4.0-linux-x64.tar.gz | tar -xvz && sudo ln -s `pwd`/flyway-11.4.0/flyway /usr/local/bin 

USER root