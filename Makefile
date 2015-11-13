SUBDIRS := basic_example blinky dweet interrupt_example $(wildcard *_ats)

all clean:
	$(foreach i,$(SUBDIRS),$(MAKE) -C $i $@ &&) true

.PHONY: all clean
