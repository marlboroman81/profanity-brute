CC=g++
CDEFINES=
SOURCES=Dispatcher.cpp Mode.cpp precomp.cpp profanity.cpp SpeedSample.cpp
OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE=profanity.x64

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	LDFLAGS=-framework OpenCL
	CFLAGS=-c -std=c++11 -Wall -mavx -O3
else
	LDFLAGS=-s -Ofast -mavx2 -march=native -m64 -mtune=native -Wno-unused-result -Wno-write-strings -ftree-vectorize -flto -lOpenCL -mcmodel=large
	CFLAGS=-c -std=c++11 -Wall -Ofast -mavx2 -march=native -m64 -mtune=native -Wno-unused-result -Wno-write-strings -ftree-vectorize -flto -mcmodel=large 
endif

all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) $(CDEFINES) $< -o $@

clean:
	rm -rf *.o *.x64
