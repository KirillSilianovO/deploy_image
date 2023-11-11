include env
export

GLOBAL_IMAGE_NAME = kirillsilianov/deploy-image
LOCAL_IMAGE_NAME = harbor.ksilianov.xyz/main/deploy_image
JUMP_IMAGE_NAME = gitlab.jump.finance:5050/k.silyanov/deploy_image

BUILDER_NAME = deploy-builder

ifeq ($(strip $(IMAGE_VERSION)),)
  VER := $(VER)
else
  VER := $(IMAGE_VERSION)
endif

builder_recreate:
	docker buildx rm $(BUILDER_NAME) || true
	docker buildx create --name $(BUILDER_NAME) --driver docker-container --use

build_push_global: builder_recreate
	docker buildx build \
		--no-cache \
		--platform linux/amd64,linux/arm64/v8 \
		-f Dockerfile \
		-t $(GLOBAL_IMAGE_NAME):latest \
		-t $(GLOBAL_IMAGE_NAME):$(VER) \
		--push . || true

build_push_local: builder_recreate
	docker buildx build \
		--no-cache \
		--platform linux/amd64,linux/arm64/v8 \
		-f Dockerfile \
		-t $(LOCAL_IMAGE_NAME):latest \
		-t $(LOCAL_IMAGE_NAME):$(VER) \
		--push . || true

build_load_local: builder_recreate
	docker buildx build \
		--no-cache \
		-f Dockerfile \
		-t $(LOCAL_IMAGE_NAME):latest \
		-t $(LOCAL_IMAGE_NAME):$(VER) \
		--load . || true

build_load_global: builder_recreate
	docker buildx build \
		--no-cache \
		-f Dockerfile \
		-t $(GLOBAL_IMAGE_NAME):latest \
		-t $(GLOBAL_IMAGE_NAME):$(VER) \
		--load . || true

build_push_jump: builder_recreate
	docker buildx build \
		--no-cache \
		-f Dockerfile \
		-t $(JUMP_IMAGE_NAME):latest \
		-t $(JUMP_IMAGE_NAME):$(VER) \
		--push . || true

build_push: build_push_local build_push_global build_push_jump