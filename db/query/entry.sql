-- name: CreateEntry :one
insert into entries (account_id, amount)
values($1, $2)
returning *;

-- name: GetEntry :one
select * from entries
where id = $1 limit 1;

-- name: ListEntries :many
select * from entries
where account_id = $1
order by id
limit $2
offset $3;

-- name: UpdateEntry :one
update entries
set amount = $2
where id = $1
returning *;

-- name: DeleteEntry :exec
delete from entries
where id = $1;