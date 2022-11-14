PSQLHOME=/var/lib/postgres
IMAGE=egym-app
REMOTE_IMAGE=nikiforomaximos/egym
HOST_PORT=8000

build-img:
	docker build --tag ${IMAGE} .

push-img:
	docker tag ${IMAGE}:latest ${REMOTE_IMAGE}:dev
	docker push ${REMOTE_IMAGE}:dev

run:
	docker container rm ${IMAGE}-container
	docker run --name ${IMAGE}-container -p ${HOST_PORT}:80 ${IMAGE}

psql-scripts:
	rm ${PSQLHOME}/scripts/egym/*
	cp scripts/db/* ${PSQLHOME}/scripts/egym/
	chown postgres ${PSQLHOME}/scripts/egym/*
