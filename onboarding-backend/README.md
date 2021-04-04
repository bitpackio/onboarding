# Onboarding Backend 
Onboarding Backend is the REST API with Go for the Onboarding Flutter Frontend using:
1. **Gin Framework**
2. **Gorm** 

## Installation
```bash
# Install Go
$ sudo apt install golang postgresql
# Download this project
$ go get github.com/bitpackio/onboarding

# Download Gin Framework
$ go get github.com/gin-gonic/gin
# Download GORM 
$ go get -u gorm.io/gorm
# Download GORM PostgreSQL Driver
$ go get -u gorm.io/driver/postgres
```

## DB Setup
1. Edit Config/Database.go
2. Update DBName, User, Password, Host and Port

## Run the server
```bash
# Compile and run
$ go run main.go
```

## Run the client
```bash
# Example curl commands to create, read, update and delete elements
$ curl -d '{"boatid":sw1,"gender":"f","scabies":0,"needs_protection":0,"medical_case":0,"nationality":"ly","age":26,"alone_traveling_woman":1,"unaccompanied_minor":0,"pregnant_woman":0,"temperature":37}' -X POST 127.0.0.1:8080/v1/people
$ curl -X GET 127.0.0.1:8080/v1/people
$ curl -X GET 127.0.0.1:8080/v1/people/1
$ curl -d '{"boatid":sw2,"gender":"m","scabies":0,"needs_protection":0,"medical_case":0,"nationality":"ly","age":38,"alone_traveling_woman":1,"unaccompanied_minor":0,"pregnant_woman":0,"temperature":33}' -X PUT 127.0.0.1:8080/v1/people/1
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
