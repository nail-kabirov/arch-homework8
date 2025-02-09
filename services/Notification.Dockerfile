# Builder image
FROM golang:1.17.2-alpine3.14 AS build

WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o ./bin/notification ./cmd/notification/

# Final image from scratch
FROM scratch
COPY --from=build /app/bin/notification /bin/notification

EXPOSE 8000
ENTRYPOINT ["/bin/notification"]
