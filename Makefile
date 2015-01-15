#
#  Default to 64-bit code
#
BITS     ?= 64

#
#  Basic C++11 + TM configuration
#
CXX	  = g++
CXXFLAGS  = -MMD -ggdb -O3 -fgnu-tm -std=c++11 -m$(BITS) -pthread
#uncomment this line if enable debug
#CXXFLAGS += -DDEBUG

LDFLAGS   = -m$(BITS) -lrt

#
#  This code needs to see the libitm.h file, so provide a path
#  here... individual users may need to override it
#
MY_LIBITM ?= /home/chw412/gcc/src/gcc_trunk/libitm/
CXXFLAGS += -I$(MY_LIBITM)

#
#  For now, libcondvar only requires condvar.cpp
#
CXXFILES  = condvar
TARGET	  = libcondvar.a

#
#  Basic makefile stuff follows...
#

OFILES    = $(patsubst %, %.o, $(CXXFILES))
DEPS      = $(patsubst %, %.d, $(CXXFILES))

all: $(TARGET)

$(TARGET): $(OFILES)
	@echo [AR] $< "-->" $@
	@$(AR) cru $@ $^

%.o:%.cpp
	@echo [CXX] $< "-->" $@
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

clean:
	@echo cleaning up...
	@rm -f $(TARGET) $(OFILES) $(DEPS)

-include $(DEPS)
