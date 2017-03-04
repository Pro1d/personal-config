############################################
#    Generic makefile for C/C++ project    #
############################################


### The following variables can personnalized ###

## [Source directory] ##
SOURCE_DIR:=./src
SOURCE_FILE_EXTENSION:=cpp

## [Object directory] ##
OBJECT_DIR:=./obj

## [binary name and location] ##
TARGET:=program

## [Compiler] ##
CXX:=g++

## [Compiler flags] ##
CXXFLAGS +=-Wall -std=c++11 -I$(SOURCE_DIR)

## [Linker flags] ##
LDFLAGS =-lm

# Enable debug with '$> make DEBUG=1', default: disabled
DEBUG ?= 0

## [Object directory and debug/release flags] ##
ifeq ($(DEBUG), 1)
	OBJECT_DIR:=$(OBJECT_DIR)/debug
	CXXFLAGS+= -g -D__DEBUG__ -O0
else
	OBJECT_DIR:=$(OBJECT_DIR)/release
	CXXFLAGS+= -O2
endif


### Files listing and recipes ###

# Find all .cpp files in source directory
SOURCES:=$(shell find $(SOURCE_DIR) -type f -name "*.$(SOURCE_FILE_EXTENSION)")

# Generate .o paths from source paths
OBJECTS:=$(patsubst $(SOURCE_DIR)/%, $(OBJECT_DIR)/%, $(SOURCES:.cpp=.o))

all: $(TARGET)

# Link objects and build binary
$(TARGET): $(OBJECTS)
	@echo -e '\e[1;34mLink and build "$@"\e[0m'
	@$(CXX) $+ $(LDFLAGS) -o $@

# pull in dependency info for *existing* .o files
-include $(OBJECTS:.o=.d)

# Compile sources with dependency auto-gen
$(OBJECT_DIR)/%.o: $(SOURCE_DIR)/%.cpp
	@# make object directory
	@mkdir -p $(@D)
	@echo -e '\e[1;34mCompile "$<"\e[0m'
	@# generate .o
	@$(CXX) -c $(CXXFLAGS) $< -o $@
	@# generate .d
	@$(CXX) -MM $(CXXFLAGS) $< > $(OBJECT_DIR)/$*.d
	@# rename .d to .d.tmp
	@mv -f $(OBJECT_DIR)/$*.d $(OBJECT_DIR)/$*.d.tmp
	@# in .d.tmp, replace recipe name to match obj directory, save in .d
	@sed -e 's|.*:|$(OBJECT_DIR)/$*.o:|' < $(OBJECT_DIR)/$*.d.tmp > $(OBJECT_DIR)/$*.d
	@# in .d.tmp remove recipe name, put all dependencies in multiple lines, append to .d
	@sed -e 's/.*://' -e 's/\\$$//' < $(OBJECT_DIR)/$*.d.tmp | fmt -1 | sed -e 's/^ *//' -e 's/$$/:/' >> $(OBJECT_DIR)/$*.d
	@# remove .d.tmp
	@rm -f $(OBJECT_DIR)/$*.d.tmp

clean:
	@echo -e '\e[1;34mRemove all *.o and *.d files\e[0m'
	@rm -f $(OBJECTS) $(OBJECTS:.o=.d)
