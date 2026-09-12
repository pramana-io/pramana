VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo dev)
LDFLAGS := -ldflags "-X main.version=$(VERSION)"

.PHONY: build vet test check tidy run clean

build:
	go build $(LDFLAGS) -o pramana ./cmd/pramana

vet:
	go vet ./...

test:
	go test ./...

check: vet test

tidy:
	go mod tidy

run: build
	./pramana

clean:
	rm -f pramana