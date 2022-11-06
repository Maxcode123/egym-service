PSQLHOME=/var/lib/postgres

psql-scripts:
	rm $(PSQLHOME)/scripts/egym/*
	cp scripts/db/* $(PSQLHOME)/scripts/egym/
	chown postgres $(PSQLHOME)/scripts/egym/*