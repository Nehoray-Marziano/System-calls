#format is target-name: target dependencies
#{-tab-}actions

# All Targets
all: F_D

# Tool invocations
# Executable "hello" depends on the files hello.o and run.o.
F_D: F_D.o
	gcc -m32 -g -Wall -o F_D F_D.o

# Depends on the source and header files
F_D.o: F_D.c
	gcc -g -Wall -m32 -ansi -c -o F_D.o F_D.c 


#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o F_D
