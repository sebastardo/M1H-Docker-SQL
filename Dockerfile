FROM python:3.13-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/

WORKDIR /coso

ENV PATH="/coso/.venv/bin:$PATH"

COPY  "pyproject.toml" "uv.lock" ".python-version" ./

RUN uv sync --locked

COPY main.py .

ENTRYPOINT ["python", "main.py"]