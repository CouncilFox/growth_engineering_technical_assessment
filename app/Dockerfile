FROM cgr.dev/chainguard/go:latest AS builder
WORKDIR /app
COPY ./src/ .
RUN go build -o app main.go

FROM cgr.dev/chainguard/go:latest AS runner
WORKDIR /app
COPY --from=builder /app/app .
EXPOSE 8080
ENTRYPOINT [ "/app/app" ]