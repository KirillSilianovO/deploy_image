IMAGE_NAME = registry.ksilianov.xyz/meta/deploy_image
VER = 1.2

ifeq ($(strip $(IMAGE_VERSION)),)
  VER := $(VER)
else
  VER := $(IMAGE_VERSION)
endif


build_amd:
	docker buildx build \
		--platform linux/amd64 \
		-t $(IMAGE_NAME):amd64-latest \
		-t $(IMAGE_NAME):amd64-$(VER) \
		--load .

build_arm:
	docker buildx build \
		--platform linux/arm64/v8 \
		-t $(IMAGE_NAME):arm64-latest \
		-t $(IMAGE_NAME):arm64-$(VER) \
		--load .

set_local_repo:
	$(eval IMAGE_NAME = harbor.ksilianov.xyz/library/deploy-image)

build_arm_local: set_local_repo build_arm

build_amd_local: set_local_repo build_amd

build: build_amd build_arm

build_push_arm: build_arm
	docker push $(IMAGE_NAME):arm64-latest
	docker push $(IMAGE_NAME):arm64-$(VER)

build_push_arm_local: build_arm_local
	docker push $(IMAGE_NAME):arm64-latest
	docker push $(IMAGE_NAME):arm64-$(VER)

build_push_amd: build_amd
	docker push $(IMAGE_NAME):amd64-latest
	docker push $(IMAGE_NAME):amd64-$(VER)

build_push_amd_local: build_amd_local
	docker push $(IMAGE_NAME):amd64-latest
	docker push $(IMAGE_NAME):amd64-$(VER)

build_push: build_push_arm build_push_amd

build_push_local: build_push_arm_local build_push_amd_local
