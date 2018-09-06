# Sql server with database created

  Creating a database and maintaning the container running.
  
```
docker build -t sql_server .
```

```
docker run --net="host" --rm -d --name=sql_server_azure sql_server
```
