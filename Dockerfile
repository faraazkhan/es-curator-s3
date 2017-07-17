FROM alpine:3.4
ENV ES_HOST=elasticsearch-logging \
    ES_PORT=9200 \
    AWS_REGION=us-west-1
RUN apk --update add curl bash
WORKDIR /usr/src
COPY ./scripts .
ENTRYPOINT ["scripts/create-s3-snapshot.sh"]
