# Change go version according to requirement
FROM golang:1.22.3-alpine3.20 AS build

# Set the working directory
WORKDIR /app

# Copy the local files to the container's workspace
COPY . .

# Download Go dependencies
RUN go mod download

# Build the Go application
RUN go build -o /myapp .

# Using a smaller image for the final container 
FROM alpine:latest AS run

# Copy the application binary from the build stage
COPY --from=build /myapp /myapp

# Set the working directory for the final container
WORKDIR /app

# Expose the port your application listens on (replace 8080 with your port)
EXPOSE 8080

# Command to run your application
CMD ["/myapp"]