# stage 1
FROM golang:1.23 AS build
WORKDIR /app
COPY go.mod .
COPY main.go .
COPY /templates ./templates

RUN CGO_ENABLED=0 go build -o goBinary .
RUN ls -lh

# stage 2
FROM scratch AS final
COPY --from=build /app/templates /templates
COPY --from=build /app/goBinary goBinary

CMD [ "./goBinary" ]
