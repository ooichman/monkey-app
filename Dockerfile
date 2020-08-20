FROM ubi8/go-toolset as build

WORKDIR /opt/app-root
COPY src src
WORKDIR /opt/app-root/src/monkey/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o monkey

FROM ubi8/ubi-minimal

WORKDIR /opt/app-root
COPY --from=build /opt/app-root/src/monkey/monkey /opt/app-root/monkey

EXPOSE 8080
ENTRYPOINT ["./monkey"]
