##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################
AESD_ASSIGNMENTS_VERSION = 72d9041842bfefc7df368be8ef068110020bf923
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-shrutikalyankar.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
	$(MAKE) -C $(@D)/server \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)"
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	# Create target directories
	$(INSTALL) -d 0755 $(TARGET_DIR)/usr/bin
	$(INSTALL) -d 0755 $(TARGET_DIR)/etc/finder-app/conf

	# Install config files
	$(INSTALL) -m 0644 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/

	# Install scripts
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/

	# Install writer binary
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/

	# Install aesdsocket binary
	$(INSTALL) -D -m 0755 $(@D)/server/aesdsocket \
		$(TARGET_DIR)/usr/bin/aesdsocket

	# Install aesdsocket init script
	$(INSTALL) -D -m 0755 $(@D)/server/aesdsocket-start-stop.sh \
		$(TARGET_DIR)/etc/init.d/S99aesdsocket
endef

$(eval $(generic-package))
