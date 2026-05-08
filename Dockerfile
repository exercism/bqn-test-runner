FROM ubuntu:24.04@sha256:c4a8d5503dfb2a3eb8ab5f807da5bc69a85730fb49b5cfca2330194ebcc41c7b AS build

RUN apt-get update && apt-get install -y \
    make \
    clang \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN git clone https://github.com/dzaima/CBQN.git && \
    cd CBQN && \
    make

FROM ubuntu:24.04@sha256:c4a8d5503dfb2a3eb8ab5f807da5bc69a85730fb49b5cfca2330194ebcc41c7b

RUN useradd appuser

WORKDIR /opt/test-runner

COPY --from=build /tmp/CBQN/BQN .
# COPY --chown=appuser:appuser . .

USER appuser
# ENTRYPOINT [ "/opt/test-runner/bin/run.sh" ]
