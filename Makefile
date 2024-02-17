# 
DIRECTORIES = ./client/ ./comments/ ./event-bus/ ./moderation/ ./posts/ ./query/

copy-lock:
	cp ./package-lock.json ./client/
	cp ./package-lock.json ./comments/
	cp ./package-lock.json ./event-bus/
	cp ./package-lock.json ./moderation/
	cp ./package-lock.json ./posts/
	cp ./package-lock.json ./query/

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