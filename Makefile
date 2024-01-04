COMANDO = odin build src -out:bin/trab -show-timings -debug

default: bin
	$(COMANDO)

bin:
	mkdir bin

release: bin
	$(COMANDO) -o:speed

clean:
	rm bin/trab
