FROM python:3.11.0-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN apt-get update && \
    apt-get -y install libpq-dev gcc
RUN pip3 install -r requirements.txt

COPY . .