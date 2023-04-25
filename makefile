IMAGE_NAME = kirillsilianov/deploy-image
IMAGE_VERSION = 0.20

build_amd:
	docker buildx build --platform linux/amd64 -t $(IMAGE_NAME):amd64-latest -t $(IMAGE_NAME):amd64-$(IMAGE_VERSION) --load .

build_arm:
	docker buildx build --platform linux/arm64/v8 -t $(IMAGE_NAME):arm64-latest -t $(IMAGE_NAME):arm64-$(IMAGE_VERSION) --load .

build: build_amd build_arm

build_push_arm: build_arm
	docker push $(IMAGE_NAME):arm64-latest
	docker push $(IMAGE_NAME):arm64-$(IMAGE_VERSION)

build_push_amd: build_amd
	docker push $(IMAGE_NAME):amd64-latest
	docker push $(IMAGE_NAME):amd64-$(IMAGE_VERSION)

build_push: build_push_arm build_push_amd