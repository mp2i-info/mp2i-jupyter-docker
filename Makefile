build:
	docker build -t mp2i .
run:
	docker run -p 8888:8888 mp2i
prune:
	docker image prune
