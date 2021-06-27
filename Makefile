build:
	docker build -t qfortier/mp2i .
run:
	docker run -p 8888:8888 qfortier/mp2i
prune:
	docker image prune
push:
	docker push qfortier/mp2i
