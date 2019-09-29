FROM python:alpine
RUN apk --no-cache add curl bash git make musl-dev go docker

ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

RUN go get github.com/subfuzion/envtpl/...

ARG KUBECTL_VERSION=v1.16.0

# Install kubectl

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && mv kubectl /usr/local/bin \
    && chmod +x /usr/local/bin/kubectl

ARG AWS_CLI_VERSION=1.16.248

# Install awscli
RUN pip install "awscli>=${AWS_CLI_VERSION}" --force

RUN curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator \
    && mv aws-iam-authenticator /usr/local/bin \
    && chmod +x /usr/local/bin/aws-iam-authenticator

ARG KAPP_VERSION=v0.13.0 

RUN curl -OL https://github.com/k14s/kapp/releases/download/${KAPP_VERSION}/kapp-linux-amd64 \
    && mv kapp-linux-amd64 /usr/local/bin/kapp \
    && chmod +x /usr/local/bin/kapp

ARG CUELANG_VERSION=0.0.11

RUN curl -OL https://github.com/cuelang/cue/releases/download/v${CUELANG_VERSION}/cue_${CUELANG_VERSION}_Linux_x86_64.tar.gz \
    && tar -xvf cue_${CUELANG_VERSION}_Linux_x86_64.tar.gz cue \
    && mv cue /usr/local/bin/ \
    && chmod +x /usr/local/bin/cue