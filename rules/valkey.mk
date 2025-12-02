# valkey package
# Valkey is a Redis-compatible fork that replaces Redis in SONiC
ifneq ($(BLDENV),buster)

    VALKEY_VERSION = 8.0.1-1~deb12u1

    VALKEY_TOOLS = valkey-tools_$(VALKEY_VERSION)_$(CONFIGURED_ARCH).deb
    $(VALKEY_TOOLS)_SRC_PATH = $(SRC_PATH)/valkey
    SONIC_MAKE_DEBS += $(VALKEY_TOOLS)

    VALKEY_TOOLS_DBG = valkey-tools-dbgsym_$(VALKEY_VERSION)_$(CONFIGURED_ARCH).deb
    $(eval $(call add_derived_package,$(VALKEY_TOOLS),$(VALKEY_TOOLS_DBG)))

    VALKEY_SERVER = valkey-server_$(VALKEY_VERSION)_$(CONFIGURED_ARCH).deb
    $(eval $(call add_derived_package,$(VALKEY_TOOLS),$(VALKEY_SERVER)))

    VALKEY_SENTINEL = valkey-sentinel_$(VALKEY_VERSION)_$(CONFIGURED_ARCH).deb
    $(VALKEY_SENTINEL)_DEPENDS += $(VALKEY_SERVER)
    $(VALKEY_SENTINEL)_RDEPENDS += $(VALKEY_SERVER)
    $(eval $(call add_derived_package,$(VALKEY_TOOLS),$(VALKEY_SENTINEL)))

    # The .c, .cpp, .h & .hpp files under src/{$DBG_SRC_ARCHIVE list}
    # are archived into debug one image to facilitate debugging.
    #
    DBG_SRC_ARCHIVE += valkey

endif
