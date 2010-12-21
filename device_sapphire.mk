#
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
#

DEVICE_PACKAGE_OVERLAYS := device/htc/sapphire/overlay

PRODUCT_PACKAGES := \
    sensors.sapphire sensors.trout

# libs and tools
PRODUCT_PACKAGES += \
    libGLES_android \
    rsg-generator \
    libRS \
    librs_jni

#add in dream keypad
TROUT_KEYMAPDIR := device/htc/sapphire/keymaps/
PRODUCT_COPY_FILES += \
    $(TROUT_KEYMAPDIR)trout-keypad.kcm.bin:/system/usr/keychars/trout-keypad.kcm.bin  \
    $(TROUT_KEYMAPDIR)trout-keypad-v3.kcm.bin:/system/usr/keychars/trout-keypad-v3.kcm.bin  \
    $(TROUT_KEYMAPDIR)trout-keypad-v2.kcm.bin:/system/usr/keychars/trout-keypad-v2.kcm.bin  \
    $(TROUT_KEYMAPDIR)trout-keypad-qwertz.kcm.bin:/system/usr/keychars/trout-keypad-qwertz.kcm.bin  \
    $(TROUT_KEYMAPDIR)trout-keypad.kl:/system/usr/keylayout/trout-keypad.kl  \
    $(TROUT_KEYMAPDIR)trout-keypad-v3.kl:/system/usr/keylayout/trout-keypad-v3.kl  \
    $(TROUT_KEYMAPDIR)trout-keypad-v2.kl:/system/usr/keylayout/trout-keypad-v2.kl  \
    $(TROUT_KEYMAPDIR)trout-keypad-qwertz.kl:/system/usr/keylayout/trout-keypad-qwertz.kl


# proprietary side of the device
$(call inherit-product-if-exists, vendor/htc/sapphire/device_sapphire-vendor.mk)

# bits that are shared between dream and sapphire
$(call inherit-product, device/htc/dream-sapphire/device_dream_sapphire.mk)

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)

