build:
	docker build -t qfortier/mp2i:jupyterlab .
run:
	docker run -p 8888:8888 qfortier/mp2i:jupyterlab
prune:
	docker image prune
push:
	docker push qfortier/mp2i:jupyterlab
rm:
	docker rmi -f $(docker images -a -q)
