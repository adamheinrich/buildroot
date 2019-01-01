################################################################################
#
# jack1
#
################################################################################

JACK1_VERSION = 0.125.0
# Do not use the official release link nor the github helper because
# the archive contains empty directories (uninitialized submodules):
JACK1_SITE = https://github.com/jackaudio/jack1.git
JACK1_SITE_METHOD = git
JACK1_GIT_SUBMODULES = YES
JACK1_LICENSE = GPL-2.0+ (jack server), LGPL-2.1+ (jack library)
JACK1_LICENSE_FILES = COPYING COPYING.GPL COPYING.LGPL
JACK1_INSTALL_STAGING = YES
JACK1_AUTORECONF = YES
JACK1_CONF_OPTS = --without-html-dir --disable-oss
JACK1_DEPENDENCIES = berkeleydb libsamplerate libsndfile alsa-lib

ifeq ($(BR2_PACKAGE_OPUS),y)
JACK1_DEPENDENCIES += opus
endif

ifeq ($(BR2_PACKAGE_READLINE),y)
JACK1_DEPENDENCIES += readline
endif

# Dependency to celt can't be met: jack1 requires celt >= 0.8.0 but we
# only have 0.5.1.3 and we cannot upgrade.

define JACK1_RUN_AUTOGEN
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) ./autogen.sh)
endef
JACK1_PRE_CONFIGURE_HOOKS += JACK1_RUN_AUTOGEN

$(eval $(autotools-package))
