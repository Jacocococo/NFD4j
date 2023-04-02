# Alternative GNU Make project makefile autogenerated by Premake

ifndef config
  config=release_x64
endif

ifndef verbose
  SILENT = @
endif

.PHONY: clean prebuild

SHELLTYPE := posix
ifeq (.exe,$(findstring .exe,$(ComSpec)))
	SHELLTYPE := msdos
endif

# Configurations
# #############################################

RESCOMP = windres
INCLUDES += -I../../src/include
FORCE_INCLUDE +=
ALL_CPPFLAGS += $(CPPFLAGS) -MD -MP $(DEFINES) $(INCLUDES)
ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
LIBS +=
LDDEPS +=
LINKCMD = $(AR) -rcs "$@" $(OBJECTS)
define PREBUILDCMDS
endef
define PRELINKCMDS
endef
define POSTBUILDCMDS
endef

ifeq ($(config),release_x64)
TARGETDIR = ../lib/Release/x64
TARGET = $(TARGETDIR)/libnfd.a
OBJDIR = ../obj/x64/Release/nfd
DEFINES += -DNDEBUG
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -O2 -Wall -Wextra -fPIC -fno-exceptions
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -O2 -Wall -Wextra -fPIC -fno-exceptions
ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -m64 -s

else ifeq ($(config),release_x86)
TARGETDIR = ../lib/Release/x86
TARGET = $(TARGETDIR)/libnfd.a
OBJDIR = ../obj/x86/Release/nfd
DEFINES += -DNDEBUG
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m32 -O2 -Wall -Wextra -fPIC -fno-exceptions
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m32 -O2 -Wall -Wextra -fPIC -fno-exceptions
ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib32 -m32 -s

else ifeq ($(config),release_arm64)
TARGETDIR = ../lib/Release/ARM64
TARGET = $(TARGETDIR)/libnfd.a
OBJDIR = ../obj/ARM64/Release/nfd
DEFINES += -DNDEBUG
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -O2 -Wall -Wextra -fPIC -fno-exceptions
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -O2 -Wall -Wextra -fPIC -fno-exceptions
ALL_LDFLAGS += $(LDFLAGS) -s

else ifeq ($(config),debug_x64)
TARGETDIR = ../lib/Debug/x64
TARGET = $(TARGETDIR)/libnfd_d.a
OBJDIR = ../obj/x64/Debug/nfd
DEFINES += -DDEBUG
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -g -Wall -Wextra -fPIC -fno-exceptions
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -g -Wall -Wextra -fPIC -fno-exceptions
ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -m64

else ifeq ($(config),debug_x86)
TARGETDIR = ../lib/Debug/x86
TARGET = $(TARGETDIR)/libnfd_d.a
OBJDIR = ../obj/x86/Debug/nfd
DEFINES += -DDEBUG
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m32 -g -Wall -Wextra -fPIC -fno-exceptions
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m32 -g -Wall -Wextra -fPIC -fno-exceptions
ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib32 -m32

else ifeq ($(config),debug_arm64)
TARGETDIR = ../lib/Debug/ARM64
TARGET = $(TARGETDIR)/libnfd_d.a
OBJDIR = ../obj/ARM64/Debug/nfd
DEFINES += -DDEBUG
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -g -Wall -Wextra -fPIC -fno-exceptions
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -g -Wall -Wextra -fPIC -fno-exceptions
ALL_LDFLAGS += $(LDFLAGS)

endif

# Per File Configurations
# #############################################


# File sets
# #############################################

GENERATED :=
OBJECTS :=

GENERATED += $(OBJDIR)/nfd_common.o
GENERATED += $(OBJDIR)/nfd_zenity.o
OBJECTS += $(OBJDIR)/nfd_common.o
OBJECTS += $(OBJDIR)/nfd_zenity.o

# Rules
# #############################################

all: $(TARGET)
	@:

$(TARGET): $(GENERATED) $(OBJECTS) $(LDDEPS) | $(TARGETDIR)
	$(PRELINKCMDS)
	@echo Linking nfd
	$(SILENT) $(LINKCMD)
	$(POSTBUILDCMDS)

$(TARGETDIR):
	@echo Creating $(TARGETDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(TARGETDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(TARGETDIR))
endif

$(OBJDIR):
	@echo Creating $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif

clean:
	@echo Cleaning nfd
ifeq (posix,$(SHELLTYPE))
	$(SILENT) rm -f  $(TARGET)
	$(SILENT) rm -rf $(GENERATED)
	$(SILENT) rm -rf $(OBJDIR)
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
	$(SILENT) if exist $(subst /,\\,$(GENERATED)) del /s /q $(subst /,\\,$(GENERATED))
	$(SILENT) if exist $(subst /,\\,$(OBJDIR)) rmdir /s /q $(subst /,\\,$(OBJDIR))
endif

prebuild: | $(OBJDIR)
	$(PREBUILDCMDS)

ifneq (,$(PCH))
$(OBJECTS): $(GCH) | $(PCH_PLACEHOLDER)
$(GCH): $(PCH) | prebuild
	@echo $(notdir $<)
	$(SILENT) $(CC) -x c-header $(ALL_CFLAGS) -o "$@" -MF "$(@:%.gch=%.d)" -c "$<"
$(PCH_PLACEHOLDER): $(GCH) | $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) touch "$@"
else
	$(SILENT) echo $null >> "$@"
endif
else
$(OBJECTS): | prebuild
endif


# File Rules
# #############################################

$(OBJDIR)/nfd_common.o: ../../src/nfd_common.c
	@echo "$(notdir $<)"
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/nfd_zenity.o: ../../src/nfd_zenity.c
	@echo "$(notdir $<)"
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(PCH_PLACEHOLDER).d
endif