CUR_DIR		:= $(shell pwd)
BIN_DIR		:= $(CUR_DIR)/_bin_calc
OBJ_DIR		:= $(CUR_DIR)/_build_calc
SRC_DIR		:= $(CUR_DIR)/src

INC_FLG		:= -I$(CUR_DIR)/inc -I$(CUR_DIR)/../cmocka/include

TARGET		:= $(BIN_DIR)/calc-test
SRCS		:= $(SRC_DIR)/calc-test.c $(SRC_DIR)/calc.c 

CC		:= gcc
CD		:= cd
GIT		:= git
CMAKE		:= cmake
MAKE		:= make
RM		:= rm 
MKDIR		:= mkdir
ECHO		:= echo
CFLAGS		:= -Wall -g -O2 $(INC_FLG) 
LDFLAGS		:= -lcmocka -L$(OBJ_DIR)/src

all:	prepare $(OBJ_DIR)/src/libcmocka.so
	@$(ECHO) "> compile $(SRCS)"
	@$(CC) $(CFLAGS) $(SRCS) -o $(TARGET) $(LDFLAGS)

$(OBJ_DIR)/cmocka:
	$(GIT) clone git://git.cryptomilk.org/projects/cmocka.git $(OBJ_DIR)/cmocka

$(OBJ_DIR)/src/libcmocka.so: $(OBJ_DIR)/cmocka
	cd $(OBJ_DIR) && $(CMAKE) cmocka 
	$(MAKE) -C $(OBJ_DIR) cmocka

prepare:
	@$(ECHO) "> create output directory($(BIN_DIR))..."
	@$(MKDIR) -p $(BIN_DIR) $(OBJ_DIR)

clean:
	@$(ECHO) "> remove $(BIN_DIR)"
	@$(RM) -Rf $(BIN_DIR)

distclean:
	@$(ECHO) "> remove $(BIN_DIR) $(OBJ_DIR)"
	@$(RM) -Rf $(BIN_DIR) $(OBJ_DIR)

