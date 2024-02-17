# 
DIRECTORIES = ./client/ ./comments/ ./event-bus/ ./moderation/ ./posts/ ./query/

copy-lock:
	for dir in $(DIRECTORIES); do \
    cp ./package-lock.json $$dir; \
  done \

clean:
  for dir in $(DIRECTORIES); do \
    rm -f $$dir/package-lock.json; \
  done \
  docker rmi $$(docker images -f "dangling=true" -q)

start:
	$(MAKE) copy-lock
	docker compose -f docker-compose.yml up -d --build
	$(MAKE) clean

stop:
	$(MAKE) clean
	docker compose down