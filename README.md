# Go Backend

## Go web frameworks and HTTP routers

### Install Gin
`go get -u github.com/gin-gonic/gin`

### Define server struct
- new folder `api` & new file `server.go`
- implement HTTP API server
- `Server` struct: serves all HTTP requests for the banking service
  - `db.Store`: allow to interact with the db
  - `gin.Engine`: send each API request to the correct handler for processing
```
type Server struct {
	store *db.Store
	router *gin.Engine
}
```
- `NewServer`: function that takes a `db.Store` as input and return a `Server`
  - create a new `Server` instance and setup all HTTP API routes
- First API route: create a new account
  - use `POST` method -> `router.POST`
  - 1 handler: `server.createAccount`
  
### Implement create accountAPI
- implement `server.createAccount` method int a new file `account.go`
- `CreateAccountRequest`: struct to store the create account request
  - new account is created -> initial balance should always be 0
  - get these input parameters from the body of the HTTP request
- always good idea to validate `CreateAccountRequest`
- uses `validator package` internally to perform data validation automatically
  - `binding`: tell Gin that the field is `required`
  - later, call the `ShouldBindJSON` function to parse the input data from HTTP request body
```
type CreateAccountParam struct {
	Owner    string `json:"owner" binding:"required"`
	Currency string `json:"currency" binding:"required,oneof=USD,EUR,CAD"`
}
```
  