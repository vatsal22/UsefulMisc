# recursively finds all .c files. Assumes corresponding .h file (if any) is in the same dir
src = $(shell find . -name "*.c") 
obj = $(src:.c=.o)
dep = $(obj:.o=.d)  # one dependency file for each source

output = main.out
CC = gcc
LDFLAGS = -lz -g # the -lz is to make sure the dependency files (.d) are used
CFLAGS = -Wall -g -std=c99

$(output): $(obj)
	$(CC) -o $@ $^ $(LDFLAGS)

-include $(dep)   # include all dep files in the makefile


# basically generates the dependency files for when we link our .o files
%.d: %.c
	@$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) >$@


.PHONY: clean
clean:
	rm -f $(obj) $(output)

.PHONY: cleandep
cleandep:
	rm -f $(dep)

.PHONY: cleanall
cleanall: clean cleandep
