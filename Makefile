postgres:
	docker run --name postgres12 -p:5433:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine
 createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank
dropdb:
	docker exec -it postgres12 dropdb simple_bank
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5433/simple_bank?sslmode=disable" -verbose down
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5433/simple_bank?sslmode=disable" -verbose up
sqlc:
	sqlc generate
test:
	go test -v -cover -short ./...
server:
	go run main.go
PHONY: postgres createdb dropdb migrateup migratedown sqlc test server