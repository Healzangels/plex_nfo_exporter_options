FROM python:3.11-slim

WORKDIR /app
RUN chmod 777 /app

COPY main.py .
COPY requirements.txt .

RUN mkdir -p logs

RUN pip install --no-cache-dir -r requirements.txt

# TARGETARCH is provided automatically by buildx (amd64, arm64, ...)
ARG TARGETARCH
ADD https://github.com/aptible/supercronic/releases/download/v0.2.29/supercronic-linux-${TARGETARCH} /usr/local/bin/supercronic
RUN chmod +x /usr/local/bin/supercronic

COPY entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r$//' /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
