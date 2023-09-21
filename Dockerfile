FROM tiacloudinfo/code-server:1.0.1

USER root

# Install Kind
RUN curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.18.0/kind-linux-amd64 && \
    chmod +x /usr/local/bin/kind

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Copy the .vscode directory to the appropriate location

COPY .vscode /home/coder/.local/share/code-server/.vscode
COPY .vscode /home/coder/project/.vscode

# Copy any Lab related tasks you have for user
# COPY deployment.yaml /home/coder/project/ 
# RUN chmod 666 /home/coder/project/deployment.yaml

USER coder
# Set working directory
WORKDIR /home/coder/project

CMD ["/lib/systemd/systemd"]


