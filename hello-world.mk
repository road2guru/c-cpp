CUR_DIR		:= $(shell pwd)
BIN_DIR		:= $(CUR_DIR)/_bin_hello_world
OBJ_DIR		:= $(CUR_DIR)/_build_hello_world
SRC_DIR		:= $(CUR_DIR)/src
INC_DIR		:= $(CUR_DIR)/inc

TARGET		:= $(BIN_DIR)/hello-world
SRCS		:= $(SRC_DIR)/hello-world.c 

CC		:= gcc
RM		:= rm 
MKDIR		:= mkdir
ECHO		:= echo
CFLAGS		:= -Wall -g -O2 -I$(INC_DIR)

all:	prepare
	@$(ECHO) "> compile $(SRCS)"
	@$(CC) $(CFLAGS) $(SRCS) -o $(TARGET)

prepare:
	@$(ECHO) "> create output directory($(BIN_DIR) $(OBJ_DIR))..."
	@$(MKDIR) -p $(BIN_DIR) $(OBJ_DIR)

clean:
	@$(ECHO) "> remove $(BIN_DIR)"
	@$(RM) -Rf $(BIN_DIR)

distclean:
	@$(ECHO) "> remove $(BIN_DIR) $(OBJ_DIR)"
	@$(RM) -Rf $(BIN_DIR) $(OBJ_DIR)

