FROM python:alpine
RUN apk --no-cache add curl bash alpine-sdk go
RUN go get github.com/subfuzion/envtpl/...

ARG KUBECTL_VERSION=v1.13.4

# Install kubectl

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && mv kubectl /usr/local/bin \
    && chmod +x /usr/local/bin/kubectl

ARG AWS_CLI_VERSION=1.16.152

# Install awscli
RUN pip install "awscli>=${AWS_CLI_VERSION}" --force

RUN curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator \
    && mv aws-iam-authenticator /usr/local/bin \
    && chmod +x /usr/local/bin/aws-iam-authenticator