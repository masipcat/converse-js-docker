FROM node:10.14-alpine as builder

ARG VERSION

RUN apk update && apk add make git ruby ruby-dev g++ libffi-dev wget zip

WORKDIR /

RUN git clone -b "${VERSION}" --single-branch --depth 1 https://github.com/conversejs/converse.js.git converse.js

WORKDIR /converse.js

RUN gem install rdoc; echo
RUN gem install ffi
RUN make dist
RUN mkdir 3rdparty && cd 3rdparty && wget https://github.com/signalapp/libsignal-protocol-javascript/raw/master/dist/libsignal-protocol.js

FROM pierrezemb/gostatic as gostatic

FROM alpine:3.8

RUN apk add --no-cache gettext

COPY --from=gostatic /goStatic /go_static
COPY entrypoint.sh /
COPY index_template.html /app/
COPY --from=builder /converse.js/dist/converse.min.js /app/static/dist/converse.min.js
COPY --from=builder /converse.js/css/ /app/static/css/
COPY --from=builder /converse.js/3rdparty/ /app/3rdparty/
COPY --from=builder /converse.js/locale/ /app/locale/

WORKDIR /app

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
