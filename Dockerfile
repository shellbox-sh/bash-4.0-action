# Following tutorial: https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action

# Container image that runs your code
FROM bash:4.0

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
