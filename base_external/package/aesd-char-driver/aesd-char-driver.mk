################################################################################
#
# aesd-char-driver
#
################################################################################
AESD_CHAR_DRIVER_VERSION = 72d9041842bfefc7df368be8ef068110020bf923
AESD_CHAR_DRIVER_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-shrutikalyankar.git
AESD_CHAR_DRIVER_SITE_METHOD = git
AESD_CHAR_DRIVER_GIT_SUBMODULES = YES

define AESD_CHAR_DRIVER_BUILD_CMDS
	$(MAKE) -C $(@D)/aesd-char-driver \
		KERNELDIR=$(LINUX_DIR) \
		CROSS_COMPILE=$(TARGET_CROSS) \
		ARCH=$(KERNEL_ARCH) \
		modules
endef

define AESD_CHAR_DRIVER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/aesd-char-driver/aesdchar.ko \
		$(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/aesdchar.ko
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_project_base_PATH)/package/aesd-char-driver/S98aesdchar \
		$(TARGET_DIR)/etc/init.d/S98aesdchar
endef

$(eval $(generic-package))
