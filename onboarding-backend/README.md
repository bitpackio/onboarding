# Onboarding Backend 
Onboarding Backend is the REST API with Go for the Onboarding Flutter Frontend using:
1. **Gin Framework**
2. **Gorm** 

## Docker Environment
```bash
# Install docker packages
$ sudo apt install docker docker-compose

# Setup environment files
$ vi etc/app.env
$ vi src/config/database.go

# Build the container
$ sudo docker-compose build
# Run the container
$ sudo docker-compose up  

Starting onboarding-backend_database_1 ... done
Starting onboarding-backend_server_1   ... done

database_1  | 2021-04-11 00:09:52.408 UTC [1] LOG:  database system is ready to accept connections
server_1    | 
server_1    | [GIN-debug] GET    /v1/people                --> bitpack.io/onboarding/controller.Get (3 handlers)
server_1    | [GIN-debug] POST   /v1/people                --> bitpack.io/onboarding/controller.Create (3 handlers)
server_1    | [GIN-debug] GET    /v1/people/:id            --> bitpack.io/onboarding/controller.Read (3 handlers)
server_1    | [GIN-debug] PUT    /v1/people/:id            --> bitpack.io/onboarding/controller.Update (3 handlers)
server_1    | [GIN-debug] DELETE /v1/people/:id            --> bitpack.io/onboarding/controller.Delete (3 handlers)
server_1    | [GIN-debug] Listening and serving HTTP on :8080
```

## Run the client
```bash
# Example curl commands to create, read, update and delete elements
$ curl -d '{"boatid":1,"gender":"f","scabies":0,"needs_protection":0,"medical_case":0,"nationality":"ly","age":26,"alone_traveling_woman":1,"unaccompanied_minor":0,"pregnant_woman":0,"temperature":37}' -X POST 127.0.0.1:8080/v1/people
$ curl -X GET 127.0.0.1:8080/v1/people
$ curl -X GET 127.0.0.1:8080/v1/people/1
$ curl -d '{"boatid":2,"gender":"m","scabies":0,"needs_protection":0,"medical_case":0,"nationality":"ly","age":38,"alone_traveling_woman":0,"unaccompanied_minor":0,"pregnant_woman":0,"temperature":33}' -X PUT 127.0.0.1:8080/v1/people/1
$ curl -X DELETE 127.0.0.1:8080/v1/people/1
```

## API list

* `GET` : Get all people
* `POST` : Create people
* `GET` : Get people
* `PUT` : Update people
* `DELETE` : Delete people

## Post Params
```
{
	"boatid": "boatid",
	"gender": "gender",
	"scabies": "scabies",
	"needs_protection": "needs_protection",
	"medical_case": "medical_case",
	"nationality": "nationality",
	"age": "age",
	"alone_traveling_woman": "alone_traveling_woman",
	"unaccompanied_minor": "unaccompanied_minor",
	"pregnant_woman": "pregnant_woman",
	"temparature": "temperature",
}
```

## Local Go Installation
```bash
# Install Go
$ sudo apt install golang postgresql
# Download Project
$ go get github.com/bitpackio/onboarding/onboarding-backend

# Setup Project
$ cd onboarding/onboarding-backend/src
# Download Gin Framework
$ go get github.com/gin-gonic/gin
# Download GORM 
$ go get -u gorm.io/gorm
# Download GORM PostgreSQL Driver
$ go get -u gorm.io/driver/postgres
```

## Local Database Setup
```bash
# Setup PostgreSQL Database
psql --host=127.0.0.1 --username=postgres --dbname=postgres
create database "onboarding-db-1";
create user onboarding with encrypted password 'changeme';
grant all privileges on database onboarding-db-1 to onboarding;

# Edit Database Configuration
vi config/database.go
# Update DBName, User, Password, Host and Port
Host: 127.0.0.1
Port: 5432
User: onboarding
Password: changeme
DBName: onboarding-db-1
```

## Run the server
```bash
# Compile and run
$ go run main.go
```
