FROM python:3.11.0-slim-buster

WORKDIR /app

RUN apt-get update && \
    apt-get -y install libpq-dev gcc

COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

ARG ACCESS_KEY_ID
ARG SECRET_ACCESS_KEY
RUN mkdir ~/.aws && \
    echo "[default]" > ~/.aws/config && \
    echo "output = json" >> ~/.aws/config && \
    echo "region = us-east-1" >> ~/.aws/config && \
    echo "[default]" > ~/.aws/credentials && \
    echo "aws_access_key_id = ${ACCESS_KEY_ID}" >> ~/.aws/credentials && \
    echo "aws_secret_access_key = ${SECRET_ACCESS_KEY}" >> ~/.aws/credentials

ENV ENVM=1
COPY api /app/api

CMD ["uvicorn", "--factory", "api.app:create_app", "--host", "0.0.0.0", "--port", "80"]