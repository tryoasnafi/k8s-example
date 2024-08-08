FROM golang:alpine AS builder

WORKDIR /app

COPY go.* .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o /exampleapp ./main.go

FROM alpine:latest AS production

WORKDIR /

COPY --from=builder /exampleapp .

CMD [ "/exampleapp" ]