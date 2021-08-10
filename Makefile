image=qfortier/mp2i
version=jupyterlab
volume=mp2i-vol

build:
	docker build -t $(image):$(version) .

volume:
	docker volume create $(volume)

run: ## --mount source=$(volume),target=/home/student
	docker run -p 8889:8888 $(image):$(version)

prune:
	docker image prune

push:
	docker push $(image):$(version)

rm:
	docker rmi -f $(docker images -a -q)
