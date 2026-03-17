FROM debian:11

SHELL ["/bin/bash", "-c"]

# Set default values for the environment variables
ARG IVYSYN_PATH=/home/ivyuser/ivysyn
ARG IVYSYN_TMP_RESULTS_PATH=/home/ivyuser/ivysyn-results

# Set the environment variables required by IvySyn
ENV IVYSYN_PATH ${IVYSYN_PATH}
ENV IVYSYN_TMP_RESULTS_PATH ${IVYSYN_TMP_RESULTS_PATH}

RUN apt-get update && apt-get install -y nano vim screen tmux git python3-pip python3-dev \
    llvm-dev clang-11 ripgrep fd-find python3-venv cmake clang-tools-11 \
    libclang-11-dev openjdk-11-jdk java-common bc build-essential clang nasm wget

# Download bazel
RUN wget https://github.com/bazelbuild/bazelisk/releases/download/v1.11.0/bazelisk-linux-amd64
RUN mv bazelisk-linux-amd64 /usr/local/bin/bazel
RUN chmod 755 /usr/local/bin/bazel

RUN useradd -m ivyuser
USER ivyuser

COPY --chown=ivyuser:ivyuser . ${IVYSYN_PATH}/

WORKDIR ${IVYSYN_PATH}

CMD ["/bin/bash"]

