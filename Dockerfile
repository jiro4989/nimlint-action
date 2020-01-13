FROM nimlang/nim:1.0.4-alpine-onbuild

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ v0.9.15

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
