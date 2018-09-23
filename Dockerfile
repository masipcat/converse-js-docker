FROM node:10.11-alpine

ARG VERSION

RUN apk update && apk add make git ruby ruby-dev g++ libffi-dev wget

WORKDIR /

RUN git clone https://github.com/conversejs/converse.js.git converse.js

WORKDIR /converse.js

RUN git checkout ${VERSION}
RUN gem install rdoc; echo
RUN gem install ffi
RUN make dist
RUN cd 3rdparty && wget https://github.com/signalapp/libsignal-protocol-javascript/raw/master/dist/libsignal-protocol.js

FROM python:3.7-alpine3.8

RUN apk update && apk add gettext
RUN mkdir -p /app/static

COPY entrypoint.sh /
COPY index.html /app/
COPY --from=0 /converse.js/dist/ /app/static/dist/
COPY --from=0 /converse.js/css/ /app/static/css/
COPY --from=0 /converse.js/3rdparty/ /app/3rdparty/
COPY --from=0 /converse.js/locale/ /app/locale/

WORKDIR /app

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
