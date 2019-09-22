FROM golang:alpine AS builder
RUN apk --update add ca-certificates

WORKDIR /src
COPY microservice.go go.* api /src/
RUN CGO_ENABLED=0 go build -o /bin/microservice

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /bin/microservice /bin/microservice
ENTRYPOINT ["/bin/microservice"]
