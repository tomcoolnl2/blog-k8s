# 
DIRECTORIES = ./client/ ./comments/ ./event-bus/ ./moderation/ ./posts/ ./query/

copy:
	for dir in $(DIRECTORIES); do \
    cp ./.env.docker $$dir; \
    cp ./package-lock.json $$dir; \
  done \

clean:
  for dir in $(DIRECTORIES); do \
    echo $$dir; \
    rm -f $$dir/.env.docker; \
    rm -f $$dir/package-lock.json; \
  done \
  docker rmi $$(docker images -f "dangling=true" -q)

start:
	$(MAKE) copy 
	docker compose -f docker-compose.yml up -d --build
	$(MAKE) clean

stop:
	$(MAKE) clean
	docker compose down