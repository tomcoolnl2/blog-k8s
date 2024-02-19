# 
SERVICES := comments event-bus moderation posts query
DOCKER_ID_USER := tomcoolnl2
DOCKERFILE := Dockerfile

k8s-copy:
	cp ./.env ./client;
	cp ./package-lock.json ./client;
	for service in $(SERVICES); do \
		cp ./.env $$service; \
		cp ./package-lock.json $$service; \
	done;

k8s-clean:
	rm -f ./client/.env;
	rm -f ./client/package-lock.json;
	for service in $(SERVICES); do \
		rm -f ./$$service/.env; \
		rm -f ./$$service/package-lock.json; \
	done;

docker-build-all:
	$(MAKE) k8s-copy;
	docker build -t $(DOCKER_ID_USER)/client -f $(DOCKERFILE) .;
	for service in $(SERVICES); do \
		docker build -t $(DOCKER_ID_USER)/$$service -f $(DOCKERFILE) .; \
	done;
	$(MAKE) k8s-clean;

docker-push-all:
	docker push $(DOCKER_ID_USER)/client;
	for service in $(SERVICES); do \
		docker push $(DOCKER_ID_USER)/$$service; \
	done;

docker-dev-copy:
	cp ./.env.local ./client;
	cp ./package-lock.json ./client;
	for service in $(SERVICES); do \
		cp ./.env.docker ./$$service; \
		cp ./package-lock.json ./$$service; \
	done;

docker-clean:
	rm -f ./client/.env ./client/.env.local
	rm -f ./client/package-lock.json
	for service in $(SERVICES); do \
		rm -f ./$$service/.env ./$$service/.env.* ; \
		rm -f ./$$service/package-lock.json ; \
	done
	docker rmi $$(docker images -f "dangling=true" -q)

docker-dev-start:
	$(MAKE) docker-copy;
	docker compose -f docker-compose.yml up -d --build;
	$(MAKE) docker-clean;

docker-dev-stop:
	docker compose down;
	$(MAKE) clean-docker;
