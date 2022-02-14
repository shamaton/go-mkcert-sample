build:
	docker build -t gomkcert .

server:
	docker run --publish 443:8080 --name gomkcertest --rm gomkcert

clean:
	docker rmi gomkcert

.PHONY: build server clean