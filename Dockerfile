FROM golang:alpine AS builder
RUN apk --update add ca-certificates

WORKDIR /src
COPY main.go go.* /src/
COPY api/* /src/api/
RUN CGO_ENABLED=0 go build -o /bin/microservice

FROM alpine
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /bin/microservice /bin/microservice
ENTRYPOINT ["/bin/microservice"]
