lastword = $(word $(words $(1)),$(1))
makedir := $(dir $(call lastword,$(MAKEFILE_LIST)))

TOPDIR := $(if $(patsubst /%,,$(makedir)),$(CURDIR)/)$(patsubst %/,%,$(makedir))

ifneq ($(BR2_ROOT),)
MAKEARGS := -C $(BR2_ROOT)
MAKEARGS += BR2_EXTERNAL=$(TOPDIR)
MAKEARGS += O=$(TOPDIR)/output
else
MAKEARGS := -C $(TOPDIR)/output
endif

BR2_EXTERNAL_FILE = $(TOPDIR)/output/.br-external
-include $(BR2_EXTERNAL_FILE)
ifeq ($(BR2_EXTERNAL),)
$(if $(BR2_ROOT),, $(error you should specify BR2_ROOT))
endif

MAKEFLAGS += --no-print-directory

.PHONY: all $(MAKECMDGOALS)

all	:= $(filter-out Makefile,$(MAKECMDGOALS))

_all:
	$(MAKE) $(MAKEARGS) $(all)

Makefile:;

$(all): _all
	@:

%/: _all
	@:
