PSQLHOME=
IMGTAR=${IMAGE}.tar
HOST_PORT=
HOST=
DEST=

build-img:
	docker build --tag ${IMAGE} .
	docker save -o ${IMGTAR} ${IMAGE}
	chmod a+rwx ${IMGTAR}

send-img:
	rsync ${IMGTAR} ${USER}@${HOST}:${DEST}

connect:
	ssh ${USER}@${HOST}

deploy:
	ssh ${USER}@${HOST} 'sudo docker load < ${DEST}${IMGTAR} && \
	docker stop app || true && docker rm app || true && \
	docker run --name app -dp ${HOST_PORT}:80 ${IMAGE}'

run:
	docker run -p ${HOST_PORT}:80 ${IMAGE}

psql-scripts:
	rm ${PSQLHOME}/scripts/egym/*
	cp scripts/db/* ${PSQLHOME}/scripts/egym/
	chown postgres ${PSQLHOME}/scripts/egym/*
