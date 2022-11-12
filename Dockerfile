FROM python:3.11.0-slim-buster

WORKDIR /app

RUN apt-get update && \
    apt-get -y install libpq-dev gcc

COPY requirements.txt /app/requirements.txt
RUN pip3 install -r requirements.txt

ENV ENVM=1
COPY api /app/api

CMD ["uvicorn", "api.app:app", "--host", "0.0.0.0", "--port", "80"]