FROM python:alpine
RUN apk --no-cache add curl

ARG KUBECTL_VERSION=v1.10.2

# Install kubectl

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && mv kubectl /usr/local/bin \
    && chmod +x /usr/local/bin/kubectl

ARG AWS_CLI_VERSION=1.16.75

# Install awscli
RUN pip install "awscli>=${AWS_CLI_VERSION}" --force --user