FROM alpine:3.9

RUN apk --no-cache add \
        bash=4.4.19-r1 \
        python=2.7.16-r1 \
        py-pip=18.1-r0 \
	    zip=3.0-r7 && \
    pip install --no-cache-dir awscli==1.17.0 && \
    apk -v --purge del py-pip

RUN apk add --no-cache \
      bash \
      zip

WORKDIR /app
COPY entrypoint.sh backup.sh ./

ENTRYPOINT [ "/app/entrypoint.sh" ]
