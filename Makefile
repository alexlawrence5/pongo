.POSIX:
AS:=nasm
ASFLAGS:=-f bin

%.bin: %.s
	sdk/build $<

.PHONY: osle_test
osle_test: osle fixtures/text.txt.bin test/fs.test.bin
	sdk/pack test/fs.test.bin vmpongz.img
	sdk/pack fixtures/text.txt.bin vmpongz.img

.PHONY: osle
osle: osle.o bin/ed.bin bin/more.bin bin/rm.bin bin/mv.bin bin/help.bin boot/bm.bin
	dd if=/dev/zero of=vmpongz.img bs=512 count=2880
	dd if=osle.o of=vmpongz.img bs=512 count=1 conv=notrunc
	sdk/pack bin/ed.bin vmpongz.img
	sdk/pack bin/more.bin vmpongz.img
	sdk/pack bin/rm.bin vmpongz.img
	sdk/pack bin/mv.bin vmpongz.img
	sdk/pack bin/help.bin vmpongz.img
	sdk/pack boot/bm.bin vmpongz.img

.PHONY: start
start: osle
	bochs -q -f .bochsrc

.PHONY: debug
debug: osle_test
	bochs -dbg -rc .bochsinit -f .bochsrc

.PHONY: clean
clean:
	rm -rf *.img *.o *.bin **/*.o **/*.bin
