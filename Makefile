image = qfortier/mp2i
version = jupyterlab

build:
	docker build -t $(image):$(version) .
run:
	docker run -p 8888:8888 $(image):$(version)
prune:
	docker image prune
push:
	docker push $(image):$(version)
rm:
	docker rmi -f $(docker images -a -q)
