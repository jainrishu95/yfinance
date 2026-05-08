FROM python:3.12-slim

WORKDIR /app

# Install uv for fast dependency management
RUN pip install uv --no-cache-dir

# Copy project files
COPY pyproject.toml .
COPY server.py .

# Create venv and install dependencies
RUN uv venv .venv
ENV VIRTUAL_ENV=/app/.venv
ENV PATH="/app/.venv/bin:$PATH"
RUN uv pip install . --no-cache

# Default port (can be overridden by cloud platform)
ENV PORT=8000
EXPOSE 8000

CMD [".venv/bin/python", "server.py"]
