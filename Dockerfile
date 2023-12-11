FROM golang:1.21.5-alpine as builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 go build -ldflags="-w -s" -o agent_sd github.com/netdata/sd/cmd/sd

FROM alpine:3.18.5

COPY --from=builder /app/agent_sd /app/

ENTRYPOINT ["/app/agent_sd"]
