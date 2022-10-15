FROM ubuntu:22.04 AS build

RUN apt-get update && apt-get install -y \
    make \
    clang \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN git clone https://github.com/dzaima/CBQN.git && \
    cd CBQN && \
    make

FROM ubuntu:22.04

RUN adduser --disabled-password --gecos "" appuser

WORKDIR /opt/test-runner
COPY --from=build /tmp/CBQN/BQN .

# COPY . .

USER appuser
# ENTRYPOINT [ "/opt/test-runner/bin/run.sh" ]

