VULKAN_SDK_PATH = $(HOME)/bin/VulkanSDK/1.1.73.0/x86_64
CFLAGS = -std=c++14 -I$(VULKAN_SDK_PATH)/include
LDFLAGS = -L$(VULKAN_SDK_PATH)/lib `pkg-config --static --libs glfw3` -lvulkan

.PHONY: all test clean

all: build

build: src/main.cpp
	@ mkdir -p build
	g++ $(CFLAGS) -o $@/Whisp src/main.cpp $(LDFLAGS) -Wl,--rpath=$(VULKAN_SDK_PATH)/lib:$(VULKAN_SDK_PATH)/etc/explicit_layer.d

test: build/Whisp
	LD_LIBRARY_PATH=$(VULKAN_SDK_PATH)/lib VK_LAYER_PATH=$(VULKAN_SDK_PATH)/etc/explicit_layer.d ./build/Whisp

clean:
	rm -rf ./build/ *.json

info:
	LD_LIBRARY_PATH=$(VULKAN_SDK_PATH)/lib $(VULKAN_SDK_PATH)/bin/vkjson_info
