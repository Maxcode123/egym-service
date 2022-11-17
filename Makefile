PSQLHOME=/var/lib/postgres
IMAGE=egym-app
REMOTE_IMAGE=nikiforomaximos/egym
HOST_PORT=8000
ACCESS_KEY_ID ?=
SECRET_ACCESS_KEY ?=

build-img:
	docker build --tag ${IMAGE} --build-arg ACCESS_KEY_ID --build-arg SECRET_ACCESS_KEY .

push-img:
	docker tag ${IMAGE}:latest ${REMOTE_IMAGE}:dev
	docker push ${REMOTE_IMAGE}:dev

pull-img:
	docker pull ${REMOTE_IMAGE}:dev

run:
	docker stop app || true && docker rm app || true
	docker run --name app -p ${HOST_PORT}:80 ${IMAGE}

psql-scripts:
	rm ${PSQLHOME}/scripts/egym/*
	cp scripts/db/* ${PSQLHOME}/scripts/egym/
	chown postgres ${PSQLHOME}/scripts/egym/*
