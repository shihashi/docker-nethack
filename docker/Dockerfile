FROM alpine AS builder
ARG PKGVER=3.6.6
RUN apk add --no-cache curl gcc make groff musl-dev ncurses-dev bison flex linux-headers util-linux && \
    curl -sL https://www.nethack.org/download/${PKGVER}/nethack-${PKGVER//.}-src.tgz | tar zx && \
    cd NetHack-NetHack-${PKGVER}_Released && \
    cd sys/unix && \
    sed -e 's|^WINTTYLIB.*|WINTTYLIB = -lncurses|' \
        -e 's/cp -n/cp/g' \
        -e '/^PREFIX/s|=.*|=/nethack|' \
        -i hints/linux && \
    sh setup.sh hints/linux && \
    cd ../.. && \
    make all && \
    make install && \
    cd .. && \
    rm -rf NetHack-NetHack-${PKGVER}_Released

FROM alpine
COPY --from=builder /nethack /nethack
RUN apk add --no-cache ncurses-libs
ENTRYPOINT ["/nethack/games/nethack"]
