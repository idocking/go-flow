FROM golang:1.9.4 as builder
WORKDIR /go/src/github.com/gogap
RUN go get -v github.com/gogap/go-flow
RUN cd go-flow && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o go-flow .

FROM golang:1.9.4-alpine3.6
RUN apk --no-cache add ca-certificates git openssh
WORKDIR /root/
COPY --from=builder /go/src/github.com/gogap/go-flow/go-flow /usr/bin
CMD ["go-flow"]