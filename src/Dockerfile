FROM alpine:latest

RUN apk update && apk add bash && apk add git

WORKDIR /app

COPY . .

CMD ./mirror_repos.sh
