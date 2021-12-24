# ARM GCC COMPILER CALL

# Toolchain To Use
TOOLCHAIN	:= arm-none-eabi-
CC		    := $(TOOLCHAIN)gcc		# c compiler
AS			:= $(TOOLCHAIN)as		# assembler
LD 			:= $(TOOLCHAIN)ld 		# linker
OBJ 		:= $(TOOLCHAIN)objcopy	# Object Copy

# -Os				Optimize for Size
# -mcpu=cortex-m4	Compile for the ARM M4 Processor
# mthumb			Target the MTHUMB Instruction Set
ARCHFLAG	:= 0
ARCH 		:= m$(ARCHFLAG)
TARGET_ARCH := -mcpu=cortex-$(ARCH)
THUMB		:= -mthumb
LINKTIME	:= -flto
CFLAGS	  	:= -Os $(TARGET_ARCH) $(THUMB) #$(LINKTIME)

SRC_DIR   	:= ./src
STD_SRC_DIR	:= $(SRC_DIR)/stm32
INC_DIR   	:= ./include
STD_INC_DIR := $(INC_DIR)/stm32
OBJ_DIR		:= ./obj

#	EXAMPLE OF AUTOMATIC VARIABLES
#	%.o: %.c %.h common.h
#		$(CC) $(CFLAGS) -c $<
#
#	$@ Looks at the target
#	(Target)
#	%.o: 			%.c %.h common.h
#	
#	$< Looks at the first source
#			(First Source)
#	%.o: 	%.c 					%.h common.h
#		$(CC) $(CFLAGS) -c $<
#	$^ Looks at the first source
#			(All Source)
#	%.o: 	%.c %.h common.h
#		$(CC) $(CFLAGS) -c $^

OBJS =	$(OBJ_DIR)/common.o \
		$(OBJ_DIR)/gpio.o \
		$(OBJ_DIR)/rcc.o \
		$(OBJ_DIR)/timer.o \
		$(OBJ_DIR)/usart.o \
		$(OBJ_DIR)/spi.o \
		$(OBJ_DIR)/nvic.o

release: $(OBJS)

# Build Dependencies
$(OBJ_DIR)/%.o: $(STD_SRC_DIR)/%.c $(STD_INC_DIR)/%.h $(STD_INC_DIR)/common.h
	$(CC) $(CFLAGS) -I$(STD_INC_DIR) -c $< -o $@

# NVIC Dependencies
$(OBJ_DIR)/nvic.o: $(STD_SRC_DIR)/nvic.c $(STD_INC_DIR)/nvic.h $(STD_INC_DIR)/common.h
	$(CC) $(CFLAGS) -I$(STD_INC_DIR) -DARCHFLAG=$(ARCHFLAG) -c $< -o $@

clean:
	rm -f $(OBJ_DIR)/*.o

setup:
	mkdir obj
