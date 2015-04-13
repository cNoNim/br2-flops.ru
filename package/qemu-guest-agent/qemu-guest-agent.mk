################################################################################
#
# qemu-guest-agent
#
################################################################################

QEMU_GUEST_AGENT_VERSION = 2.2.0
QEMU_GUEST_AGENT_SOURCE = qemu-$(QEMU_GUEST_AGENT_VERSION).tar.bz2
QEMU_GUEST_AGENT_SITE = http://wiki.qemu.org/download
QEMU_GUEST_AGENT_LICENSE = GPLv2 LGPLv2.1 MIT BSD-3c BSD-2c Others/BSD-1c
QEMU_GUEST_AGENT_LICENSE_FILES = COPYING COPYING.LIB
# NOTE: there is no top-level license file for non-(L)GPL licenses;
#       the non-(L)GPL license texts are specified in the affected
#       individual source files.

QEMU_GUEST_AGENT_DEPENDENCIES = host-pkgconf host-python libglib2 zlib pixman

# Need the LIBS variable because librt and libm are
# not automatically pulled. :-(
QEMU_GUEST_AGENT_LIBS = -lrt -lm

QEMU_GUEST_AGENT_VARS = \
	LIBTOOL=$(HOST_DIR)/usr/bin/libtool \
	PYTHON=$(HOST_DIR)/usr/bin/python2 \
	PYTHONPATH=$(TARGET_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages

define QEMU_GUEST_AGENT_CONFIGURE_CMDS
	( cd $(@D);                            \
		LIBS='$(QEMU_GUEST_AGENT_LIBS)'    \
		$(TARGET_CONFIGURE_OPTS)           \
		$(TARGET_CONFIGURE_ARGS)           \
		$(QEMU_GUEST_AGENT_VARS)           \
		./configure                        \
			--prefix=/usr                  \
			--cross-prefix=$(TARGET_CROSS) \
			--with-system-pixman           \
			--disable-linux-user           \
			--disable-system               \
			--disable-werror               \
			--disable-bsd-user             \
			--disable-xen                  \
			--disable-slirp                \
			--disable-vnc                  \
			--disable-virtfs               \
			--disable-brlapi               \
			--disable-curses               \
			--disable-curl                 \
			--disable-bluez                \
			--disable-guest-base           \
			--disable-uuid                 \
			--disable-vde                  \
			--disable-linux-aio            \
			--disable-cap-ng               \
			--disable-docs                 \
			--disable-spice                \
			--disable-rbd                  \
			--disable-libiscsi             \
			--disable-usb-redir            \
			--disable-smartcard-nss        \
			--disable-strip                \
			--disable-seccomp              \
			--disable-sparse               \
			--disable-tools                \
			--enable-guest-agent           \
	)
endef

define QEMU_GUEST_AGENT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) qemu-ga
endef

define QEMU_GUEST_AGENT_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(QEMU_GUEST_AGENT_MAKE_ENV) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))