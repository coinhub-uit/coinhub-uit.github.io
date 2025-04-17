default: start

set windows-shell := ["cmd", "/c"]

start:
  npm run start

build:
  npm run build

prod: build
  npm run serve
