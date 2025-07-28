# Step 1: 使用官方的 Python 瘦身版镜像作为基础
# "slim" 版本不包含很多系统工具，可以显著减小最终镜像的体积。
FROM python:3.13-slim

# Step 2: 设置工作目录
# 容器内所有后续操作都将在此目录下进行。
WORKDIR /app

# Step 3: 安装 Poetry
# 我们使用 pip 安装 poetry，这是在 Docker 环境中最直接的方式。
# --no-cache-dir 选项可以减小镜像层的大小。
RUN pip install --no-cache-dir poetry

# Step 4: 复制依赖管理文件
# 只复制这两个文件，而不是整个项目，是为了利用 Docker 的层缓存机制。
# 只要这两个文件不变，下一步的依赖安装层就不会重新执行，从而大大加快构建速度。
COPY pyproject.toml poetry.lock ./

# Step 5: 使用 Poetry 安装项目依赖
# --no-dev: 不安装开发依赖（如 pytest, ruff），减小生产镜像体积。
# --no-interaction: 避免任何交互式提问。
# --no-ansi: 输出纯净的日志。
RUN poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi

# Step 6: 复制应用源代码到工作目录
# 将你的核心代码包 aura_phor 复制到容器的 /app 目录下。
COPY ./aura_phor ./aura_phor

# Step 7: 暴露端口
# 告诉 Docker 容器在运行时将监听 8501 端口（Streamlit 的默认端口）。
EXPOSE 8501

# Step 8: 定义容器启动命令
# 使用 streamlit run 命令启动应用。
# --server.port 和 --server.address=0.0.0.0 是为了确保 Streamlit 能在 Docker 环境中被正确访问。
CMD ["streamlit", "run", "aura_phor/app.py", "--server.port=8501", "--server.address=0.0.0.0"]