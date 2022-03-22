.PHONY: build test shell clean

build:
	docker build -t nlcd .

test:
	docker run --rm -v "${PWD}/test":/tmp nlcd my_address_file_geocoded.csv
	docker run --rm -v "${PWD}/test":/tmp nlcd my_address_file_geocoded.csv 0

shell:
	docker run --rm -it --entrypoint=/bin/bash -v "${PWD}/test":/tmp nlcd

clean:
	docker system prune -f
