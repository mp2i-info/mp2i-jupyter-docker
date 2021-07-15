image = qfortier/mp2i
version = jupyterlab
volume = mp2i-vol

build:
	docker build -t $(image):$(version) .

volume:
	docker volume create $(volume)

run:
	docker run -p 8888:8888 --mount source=$(volume),target=/home/student $(image):$(version)

prune:
	docker image prune

push:
	docker push $(image):$(version)

rm:
	docker rmi -f $(docker images -a -q)
