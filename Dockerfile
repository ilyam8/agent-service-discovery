FROM golang:1.21.4-alpine as builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 go build -ldflags="-w -s" -o agent_sd github.com/netdata/sd/cmd/sd

FROM alpine:3.18.4

COPY --from=builder /app/agent_sd /app/

ENTRYPOINT ["/app/agent_sd"]
