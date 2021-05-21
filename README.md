# README

## [Task](https://www.notion.so/resumeio/Lead-Backend-Engineer-Challendge-95f1574344d84437ba978b21832cd162)
## Setup
Run PG via docker, or edit database.yml
```
docker run --rm --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres
```
Install dependencies and setup DB
```
bundle && rails db:setup
```

Run server
```
rails s
```
