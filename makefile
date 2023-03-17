IMAGE_NAME = kirillsilianov/deploy-image
IMAGE_VERSION = 0.12

build:
	docker buildx build --platform linux/amd64,linux/arm/v8 -t $(IMAGE_NAME):$(IMAGE_VERSION) -t $(IMAGE_NAME):latest .
	docker buildx build --load -t $(IMAGE_NAME):$(IMAGE_VERSION) -t $(IMAGE_NAME):latest .

build_push: build
	docker push $(IMAGE_NAME) --all-tags