FROM alpine

RUN apk update && apk add docker
ADD artifacts/interface.sh /usr/local/bin/interface.sh
RUN chmod +x /usr/local/bin/interface.sh
CMD ["/usr/local/bin/interface.sh"]
