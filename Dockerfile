FROM microsoft/mssql-server-linux:2017-latest

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=Sa.123456
ENV MSSQL_PID=Developer
EXPOSE 1433
WORKDIR /src

COPY banco.sql ./
COPY entrypoint.sh ./
COPY setup-database.sh ./

CMD /bin/bash ./entrypoint.sh