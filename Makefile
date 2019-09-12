# Used to recursively find .c files (even in nested directories), and compile/link into a convenient executable. 
# Assumption: corresponding .h files (if any) will be in the same directory as the .c file

src = $(shell find . -name "*.c") 
obj = $(src:.c=.o)
dep = $(obj:.o=.d)  # one dependency file for each source

output = main.out
CC = gcc
LDFLAGS = -lz # the -lz is to make sure the dependency files (.d) are used
CFLAGS = -Wall -g -std=c99

$(output): $(obj)
	$(CC) -o $@ $^ $(LDFLAGS)

# Makefile automatically compiles .c to .o files using $(CFLAGS)

# include all dep files in the Makefile
-include $(dep)   
%.d: %.c
	@$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) >$@


# cleanup
.PHONY: clean
.PHONY: cleandep
.PHONY: cleanall

clean:
	rm -f $(obj) $(output)

cleandep:
	rm -f $(dep)

cleanall: clean cleandep
