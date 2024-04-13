# 使用Ubuntu最新稳定版作为基础镜像
FROM ubuntu:latest

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    openssh-server \
    zsh \
    vim \
    curl \
    gnupg \
    lsb-release

# 设置SSH服务
RUN mkdir /var/run/sshd
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

# 添加SSH公钥
RUN mkdir -p /root/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCkjwSUhHunA+Ubr4h0KI6YvwVy0iyWgpSIW2eW3MV7Ko1c8LQtLNEtEOmAydpc0H/E4G/nRPcej8QSD6IP+rb/RUNPhjmBxsnNCtdVXQ8ArqBuWdhIybuF6VZJeSQn4nOTb0ILUbhccAJyRWL9M3eDA/Wpds0PJe3pwn6SV3QfbD7KjdUgBDnv7cKKHzwgBhCCOjw0wHaEhZ+QdMCiWKFqiTeHwc8JipOiRxv2hdS6jyxAo8QW4ChtyqKt0a58sSZwEGHZEB9GyOMNzPV95NYVQTkFp7Rq6qjmt4olsFN2UXgkI7OfOnRrVjhOMDvO+9trDcoul9hPsfGsbTYyV6wV fox@vvfox.com" > /root/.ssh/authorized_keys

# 安装Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# 安装Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 清理安装后的不必要文件
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 暴露22端口用于SSH服务
EXPOSE 22

# 设置容器启动时执行的命令
CMD ["/usr/sbin/sshd", "-D"]
