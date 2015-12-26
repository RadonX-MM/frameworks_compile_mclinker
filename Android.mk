LOCAL_PATH := $(call my-dir)
MCLD_ROOT_PATH := $(LOCAL_PATH)
# For mcld.mk
LLVM_ROOT_PATH := external/llvm
MCLD_ENABLE_ASSERTION := false

include $(CLEAR_VARS)

# MCLinker Libraries
subdirs := \
  lib/ADT \
  lib/Core \
  lib/Fragment \
  lib/LD \
  lib/MC \
  lib/Object \
  lib/Script \
  lib/Support \
  lib/Target

ifneq (, $(findstring arm,$(TARGET_ARCH)))
# ARM Code Generation Libraries
subdirs += \
  lib/Target/ARM \
  lib/Target/ARM/TargetInfo
endif

ifeq ($(strip $(TARGET_ARCH)),arm64)
# AArch64 Code Generation Libraries
subdirs += \
  lib/Target/AArch64 \
  lib/Target/AArch64/TargetInfo
endif

ifneq (, $(findstring mips,$(TARGET_ARCH)))
# MIPS Code Generation Libraries
subdirs += \
  lib/Target/Mips \
  lib/Target/Mips/TargetInfo
endif

ifneq (, $(findstring x86,$(TARGET_ARCH)))
# X86 Code Generation Libraries
subdirs += \
  lib/Target/X86 \
  lib/Target/X86/TargetInfo
ifeq ($(BUILD_ARM_FOR_X86),true)
subdirs += \
  lib/Target/ARM \
  lib/Target/ARM/TargetInfo \
  lib/Target/AArch64 \
  lib/Target/AArch64/TargetInfo
endif
endif

# mcld executable
subdirs += tools/mcld

include $(MCLD_ROOT_PATH)/mcld.mk
include $(addprefix $(LOCAL_PATH)/,$(addsuffix /Android.mk, $(subdirs)))
