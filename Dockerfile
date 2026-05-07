FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PORT=8501

WORKDIR /app/transfer_iq

RUN apt-get update && \
    apt-get install -y --no-install-recommends libgomp1 && \
    rm -rf /var/lib/apt/lists/*

COPY transfer_iq/config/requirements.txt ./config/requirements.txt

RUN python -m pip install --upgrade pip && \
    pip install -r config/requirements.txt

COPY transfer_iq/ ./

EXPOSE 8501

CMD ["sh", "-c", "streamlit run app/app.py --server.address 0.0.0.0 --server.port ${PORT} --server.headless true --browser.gatherUsageStats false"]
