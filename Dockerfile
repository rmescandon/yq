FROM golang:1.9 as builder

WORKDIR /go/src/mikefarah/yq

COPY . /go/src/mikefarah/yq

RUN scripts/devtools.sh
RUN CGO_ENABLED=0 make local build

# Choose alpine as a base image to make this useful for CI, as many
# CI tools expect an interactive shell inside the container
FROM alpine:3.7

COPY --from=builder /go/src/mikefarah/yq/yq /usr/bin/yq
RUN chmod +x /usr/bin/yq

WORKDIR /workdir
