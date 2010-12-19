# Copyright (C) 2009 The Android Open Source Project
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
# This file is the build configuration for a generic Android
# build for sapphire hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

# Inherit from those products. Most specific first.
$(call inherit-product, device/htc/sapphire/device_sapphire_us.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)

#add in dream keypad
TROUT_KEYMAPDIR=device/htc/sapphire/keymaps/
PRODUCT_COPY_FILES += \
    $(TROUT_KEYMAPDIR)trout-keypad.kcm.bin:/system/usr/keychars/trout-keypad.kcm.bin  \
    $(TROUT_KEYMAPDIR)trout-keypad-v3.kcm.bin:/system/usr/keychars/trout-keypad-v3.kcm.bin  \
    $(TROUT_KEYMAPDIR)trout-keypad-v2.kcm.bin:/system/usr/keychars/trout-keypad-v2.kcm.bin  \
    $(TROUT_KEYMAPDIR)trout-keypad-qwertz.kcm.bin:/system/usr/keychars/trout-keypad-qwertz.kcm.bin  \
    $(TROUT_KEYMAPDIR)trout-keypad.kl:/system/usr/keylayout/trout-keypad.kl  \
    $(TROUT_KEYMAPDIR)trout-keypad-v3.kl:/system/usr/keylayout/trout-keypad-v3.kl  \
    $(TROUT_KEYMAPDIR)trout-keypad-v2.kl:/system/usr/keylayout/trout-keypad-v2.kl  \
    $(TROUT_KEYMAPDIR)trout-keypad-qwertz.kl:/system/usr/keylayout/trout-keypad-qwertz.kl  \

# Discard inherited values and use our own instead.
PRODUCT_NAME := dream_sapphire
PRODUCT_DEVICE := sapphire
