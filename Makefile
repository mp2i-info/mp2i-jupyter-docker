image=qfortier/mp2i
version=3.0.0
path=.

build:
	docker build -t $(image):$(version) $(path)

run:
	docker run -p 8891:8888 -e JUPYTER_ENABLE_LAB=yes -v $(pwd):/home/jovyan/work $(image):$(version)

prune:
	docker image prune

push: build
	docker push $(image):$(version)

rm:
	docker rmi -f $(docker images -a -q)
