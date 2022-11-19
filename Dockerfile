FROM python:3.11.0-slim-buster

WORKDIR /app

RUN apt-get update && \
    apt-get -y install libpq-dev gcc

COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

ENV ENVM=1
COPY api /app/api
COPY .aws /root/.aws

CMD ["uvicorn", "--factory", "api.app:create_app", "--host", "0.0.0.0", "--port", "80"]