FROM debian:bookworm-slim

RUN set -ex; \
    adduser --uid 1000 --disabled-password --gecos '' app; \
    apt-get update; \
    apt-get install -y --no-install-recommends tini; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8
ENV TZ=Asia/Shanghai

SHELL ["tini", "-g", "--", "bash", "-c", "--"]
ENTRYPOINT ["tini", "-g", "--"]
CMD ["bash"]
