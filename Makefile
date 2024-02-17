# 
DIRECTORIES = ./comments ./event-bus ./moderation ./posts ./query

copy:
	cp ./.env.local ./client;
	cp ./package-lock.json ./client;

	for dir in $(DIRECTORIES); do \
		cp ./.env.docker $$dir; \
		cp ./package-lock.json $$dir; \
	done;

clean:
	rm -f ./client/.env.local;
	rm -f ./client/package-lock.json;

	for dir in $(DIRECTORIES); do \
		rm -f $$dir/.env.docker; \
		rm -f $$dir/package-lock.json; \
	done;

	docker rmi $$(docker images -f "dangling=true" -q)

start:
	$(MAKE) copy 
	docker compose -f docker-compose.yml up -d --build
	$(MAKE) clean

stop:
	docker compose down
	$(MAKE) clean