# 
SERVICES := client comments event-bus moderation posts query
DOCKER_ID_USER := tomcoolnl2
DOCKERFILE := Dockerfile

copy:
	for service in $(SERVICES); do \
		cp ./.env ./$$service; && cp ./.env.* ./$$service; \
		cp ./package-lock.json ./$$service; \
	done;

clean:
	docker rmi $$(docker images -f "dangling=true" -q)
	for service in $(SERVICES); do \
		rm -f ./$$service/.env ./$$service/.env.* ; \
		rm -f ./$$service/package-lock.json ; \
	done

docker-build-all:
	$(MAKE) copy;
	for service in $(SERVICES); do \
		docker build -t $(DOCKER_ID_USER)/$$service -f $(DOCKERFILE) .; \
	done;
	$(MAKE) clean;

docker-push-all:
	for service in $(SERVICES); do \
		docker push $(DOCKER_ID_USER)/$$service; \
	done;

docker-dev-start:
	$(MAKE) copy;
	docker compose -f docker-compose.yml up -d --build;
	$(MAKE) clean;

docker-dev-stop:
	docker compose down;
	$(MAKE) docker;
