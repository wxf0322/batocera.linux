################################################################################
#
# recalbox-manager
#
################################################################################
RECALBOX_MANAGER_VERSION = 1.1.0
RECALBOX_MANAGER_SITE = $(call github,digitallumberjack,recalbox-manager,$(RECALBOX_MANAGER_VERSION))
RECALBOX_MANAGER_DEPENDENCIES = python python-psutil python-django python-autobreadcrumbs

define RECALBOX_MANAGER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/recalbox-manager
	cp -r $(@D)/* $(TARGET_DIR)/usr/recalbox-manager
	cp package/recalbox-manager/bd/db.sqlite3 $(TARGET_DIR)/usr/recalbox-manager
endef

define RECALBOX_MANAGER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/recalbox-manager/script/S94manager $(TARGET_DIR)/etc/init.d/S94manager
endef


$(eval $(generic-package))
