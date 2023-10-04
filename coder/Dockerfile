FROM debian:11-slim

RUN apt update -y && apt install -y curl

RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# CMD ["code-server", "--bind-addr", "0.0.0.0:5801", "--password", "1234"]
CMD ["code-server", "--bind-addr", "0.0.0.0:5801"]
