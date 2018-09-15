
BIN_DIR		:= _bin

TARGET		:= $(BIN_DIR)/hello-world
SRCS		:= src/hello-world.c

CC			:= gcc
RM			:= rm 
MKDIR		:= mkdir
ECHO		:= echo
CFLAG		:= -Wall -g -O2

all:	prepare
	@$(ECHO) "> compile $(SRCS)"
	@$(CC) $(CFLAGS) $(SRCS) -o $(TARGET)

prepare:
	@$(ECHO) "> create output directory($(BIN_DIR))..."
	@$(MKDIR) -p $(BIN_DIR)

clean:
	@$(ECHO) "> remove $(BIN_DIR)"
	@$(RM) -Rf $(BIN_DIR)

