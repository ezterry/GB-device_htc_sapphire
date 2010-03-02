# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


ifeq ($(TARGET_DEVICE),sapphire)
ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH:= $(call my-dir)

#
# sndrpc
#

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= sndrpc.c

LOCAL_CFLAGS:= \
	-fno-short-enums \
	-include $(TARGET_OUT_HEADERS)/libcommondefs-rpc/inc/commondefs.h \
	-include $(TARGET_OUT_HEADERS)/libsnd-rpc/inc/snd_dream.h \
	-include $(TARGET_OUT_HEADERS)/libsnd-rpc/inc/snd_common.h \
	-DVOC_CODEC_DEFAULT=0  # backward compat server with ARM9

LOCAL_STATIC_LIBRARIES += \
	libsnd-rpc \
	libcommondefs-rpc

LOCAL_SHARED_LIBRARIES += librpc

LOCAL_C_INCLUDES:= \
	$(TARGET_OUT_HEADERS)/librpc \
	$(TARGET_OUT_HEADERS)/libpcm \
	$(TARGET_OUT_HEADERS)/libsnd-rpc \
	$(TARGET_OUT_HEADERS)/libcommondefs-rpc

LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE:= sndrpc

include $(BUILD_EXECUTABLE)

#
# btconfig
#

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= btconfig.c

LOCAL_SHARED_LIBRARIES += libbluetooth

LOCAL_C_INCLUDES:= $(call include-path-for, bluez-libs)

LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE:= btconfig

include $(BUILD_EXECUTABLE)

endif # not BUILD_TINY_ANDROID
endif # TARGET_DEVICE
