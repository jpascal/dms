FROM golang:1.16 AS backend

WORKDIR /builder
COPY ./ /builder

RUN CGO_ENABLED=0 go build -o ./dist/bin/dms ./main.go

FROM alpine:3.14.0

RUN apk update && apk add ffmpeg ffmpegthumbnailer

WORKDIR /app

COPY --from=backend /builder/dist /app/
