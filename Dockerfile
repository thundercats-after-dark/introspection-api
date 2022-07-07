# syntax=docker/dockerfile:1
# https://hub.docker.com/_/golang
FROM golang:1.18.3-buster as build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . ./
RUN CGO_ENABLED=0 go build -o /api app/

# https://github.com/GoogleContainerTools/distroless
FROM gcr.io/distroless/static-debian10
WORKDIR /
COPY --from=build /api /api
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["/api"]
