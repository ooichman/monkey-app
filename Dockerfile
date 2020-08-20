FROM ubi8/go-toolset as build

WORKDIR /opt/app-root
COPY * .
RUN go build src/monkey/main.go

FROM ubi8/ubi-minimal

WORKDIR /opt/app-root
COPY --from=build /opt/app-root/monkey /opt/app-root/monkey

EXPOSE 8080
ENTRYPOINT ["./monkey"]
