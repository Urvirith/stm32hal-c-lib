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
ARCH 		:= m0
TARGET_ARCH := -mcpu=cortex-$(ARCH)
THUMB		:= -mthumb
LINKTIME	:= -flto
CFLAGS	  	:= -Os $(TARGET_ARCH) $(THUMB) #$(LINKTIME)

SRC_DIR   	:= ./src
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
		$(OBJ_DIR)/spi.o

release: $(OBJS)

# Build Dependances
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(SRC_DIR)/%.h $(SRC_DIR)/common.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ_DIR)/*.o

setup:
	mkdir obj
