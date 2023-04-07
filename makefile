IMAGE_NAME = kirillsilianov/deploy-image
IMAGE_VERSION = 0.16

build_amd:
	docker buildx build \
		--platform linux/amd64 \
		--build-arg TARGETPLATFORM=amd64 \
		--build-arg BUILDPLATFORM=linux/amd64 \
		-t $(IMAGE_NAME):$(IMAGE_VERSION)-amd64 \
		-t $(IMAGE_NAME):latest-amd64 --load .

build_arm:
	docker buildx build \
		--platform linux/arm/v8 \
		--build-arg TARGETPLATFORM=arm64 \
		--build-arg BUILDPLATFORM=linux/arm/v8 \
		-t $(IMAGE_NAME):$(IMAGE_VERSION)-arm64 \
		-t $(IMAGE_NAME):latest-arm64 --load .

build_push: build_amd build_arm
	docker push $(IMAGE_NAME) --all-tags