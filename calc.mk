#
# sample that requires `cmocka` in order to work
# let's checkout `cmocka` at compile time, that means `cmocka` will
# be added as dependency
#
# Workflow:
# 1. Clone `cmocka` then reset to special commit that confirmed work
# 2. Build `cmocka`
# 3. Copy output lib `libcmocka.so*` to bin directory
# 4. Build sample app that use `cmocka` lib which built from previous
#    steps
#

CUR_DIR		:= $(shell pwd)
BIN_DIR		:= $(CUR_DIR)/_bin_calc
OBJ_DIR		:= $(CUR_DIR)/_build_calc
SRC_DIR		:= $(CUR_DIR)/src
CMOCKA_DIR	:= $(OBJ_DIR)/cmocka

INC_FLG		:= -I$(CUR_DIR)/inc -I$(CMOCKA_DIR)/include

TARGET		:= $(BIN_DIR)/calc-test
SRCS		:= $(SRC_DIR)/calc-test.c $(SRC_DIR)/calc.c 

CC		:= gcc
CD		:= cd
CP		:= cp -f
GIT		:= git
CMAKE		:= cmake
MAKE		:= make
RM		:= rm 
MKDIR		:= mkdir
ECHO		:= echo
CHMOD		:= chmod
CFLAGS		:= -Wall -g -O2 $(INC_FLG) 
LDFLAGS		:= -lcmocka -L$(BIN_DIR)

all: $(TARGET)

$(TARGET): $(SRCS) $(BIN_DIR)/libcmocka.so
	@$(ECHO) "> compile $@"
	@$(CC) $(CFLAGS) $(SRCS) -o $@ $(LDFLAGS)
	@$(ECHO) "LD_LIBRARY_PATH=$(BIN_DIR) $@" > $(BIN_DIR)/run_all.sh
	@$(CHMOD) +x $(BIN_DIR)/run_all.sh

$(OBJ_DIR)/src/libcmocka.so: $(OBJ_DIR) $(CMOCKA_DIR)
	@$(ECHO) "> build cmocka..."
	@$(CD) $(OBJ_DIR) && $(CMAKE) cmocka 
	@$(MAKE) -C $(OBJ_DIR) cmocka

$(BIN_DIR)/libcmocka.so: $(OBJ_DIR)/src/libcmocka.so $(BIN_DIR)
	@$(CP) $(OBJ_DIR)/src/libcmocka.so* $(BIN_DIR)

$(OBJ_DIR)/cmocka:
	@$(ECHO) "> clone cmocka..."
	@$(GIT) clone git://git.cryptomilk.org/projects/cmocka.git $@
	
	# make sure samples always works even cmocka may change in feature,
	# let's checkout the commit that was confirmed working
	@$(CD) $@ && $(GIT) reset --hard ae34d16

$(BIN_DIR):
	@$(ECHO) "> create output directory for executables ($@)..."
	@$(MKDIR) -p $@

$(OBJ_DIR):
	@$(ECHO) "> create output directory for objects ($@)..."
	@$(MKDIR) -p $@

run_all: $(TARGET)
	LD_LIBRARY_PATH=$(BIN_DIR) $<

clean:
	@$(ECHO) "> remove $(BIN_DIR)"
	@$(RM) -Rf $(BIN_DIR)

distclean:
	@$(ECHO) "> remove $(BIN_DIR) $(OBJ_DIR)"
	@$(RM) -Rf $(BIN_DIR) $(OBJ_DIR)

