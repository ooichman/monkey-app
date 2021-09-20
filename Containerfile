FROM golang:alpine as build

WORKDIR /opt/app-root
ENV GOPATH=/opt/app-root/
COPY src src
WORKDIR /opt/app-root/src/monkey/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o monkey

#FROM scratch
FROM ubi8/ubi-minimal

WORKDIR /opt/app-root
COPY --from=build /opt/app-root/src/monkey/monkey /opt/app-root/monkey
COPY index.html /opt/app-root/

USER 1001
EXPOSE 8080
ENTRYPOINT ["/opt/app-root/monkey"]
CMD ["/opt/app-root/monkey"]
