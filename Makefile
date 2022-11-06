PSQLHOME=/var/lib/postgres
IMAGE=egym-app

build-img:
	docker build --tag $(IMAGE) .

psql-scripts:
	rm $(PSQLHOME)/scripts/egym/*
	cp scripts/db/* $(PSQLHOME)/scripts/egym/
	chown postgres $(PSQLHOME)/scripts/egym/*