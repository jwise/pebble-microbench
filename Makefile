run: build
	pebble install --phone 192.168.1.109 --logs
	
%.S.o: %.S
	$(shell dirname `which pebble`)/../arm-cs-tools/bin/arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -c -o $@ $<
	
build: src/dut.S.o src/microbench.c
	pebble build