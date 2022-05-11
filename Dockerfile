# Container image that runs your code
FROM amazonlinux:latest
ARG PYTHON_VERSION=3.6.4
ARG BOTO3_VERSION=1.6.3
ARG BOTOCORE_VERSION=1.9.3

RUN yum install -y -q git wget jq unzip && wget 'https://github.com/mikefarah/yq/releases/download/v4.9.8/yq_linux_amd64' -O /usr/local/bin/yq && chmod +x /usr/local/bin/yq

RUN amazon-linux-extras install python3 -y && rm -f /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python

RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && unzip awscli-bundle.zip && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws


# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
