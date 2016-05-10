FROM wehkamp/alpine:3.2
EXPOSE 9108

ENV GOPATH /go
ENV APPPATH $GOPATH/src

ADD *.go Makefile* $APPPATH/

WORKDIR $APPPATH

RUN apk add --update curl git make \
    && make TARGET=/bin/elasticsearch-exporter \
    && apk del --purge git make \
    && rm -rf $GOPATH

ENTRYPOINT [ "/bin/elasticsearch-exporter" ]

LABEL container.name="wehkamp/prometheus-elasticsearch-exporter:1.0"
