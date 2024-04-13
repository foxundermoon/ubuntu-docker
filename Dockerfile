# 使用Ubuntu最新稳定版作为基础镜像
FROM ubuntu:latest

# 安装必要的软件包
RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    zsh \
    vim \
    curl \
    gnupg \
    lsb-release \
    git && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs && \
    mkdir /var/run/sshd && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    mkdir -p /root/.ssh &&\
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCkjwSUhHunA+Ubr4h0KI6YvwVy0iyWgpSIW2eW3MV7Ko1c8LQtLNEtEOmAydpc0H/E4G/nRPcej8QSD6IP+rb/RUNPhjmBxsnNCtdVXQ8ArqBuWdhIybuF6VZJeSQn4nOTb0ILUbhccAJyRWL9M3eDA/Wpds0PJe3pwn6SV3QfbD7KjdUgBDnv7cKKHzwgBhCCOjw0wHaEhZ+QdMCiWKFqiTeHwc8JipOiRxv2hdS6jyxAo8QW4ChtyqKt0a58sSZwEGHZEB9GyOMNzPV95NYVQTkFp7Rq6qjmt4olsFN2UXgkI7OfOnRrVjhOMDvO+9trDcoul9hPsfGsbTYyV6wV fox@vvfox.com" > /root/.ssh/authorized_keys && \
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    sed -i 's|/bin/bash|/usr/bin/zsh|' /etc/passwd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
