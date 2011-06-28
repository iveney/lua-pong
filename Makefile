BIN=engine
TESTBIN=test

CC=gcc
ifeq ($(findstring /Users,$(HOME)),/Users)
#LIBS=-llua -llualib `pkg-config sdl --libs --cflags` -framework OpenGL -I/opt/local/include
LIBS=`pkg-config lua --cflags --libs` \
     -framework sdl -I/Library/Frameworks/SDL.framework/Headers  \
     -framework sdl_mixer \
     -framework Cocoa \
     -framework OpenGL
else
LIBS=-llua50 -llualib50 `pkg-config sdl --libs --cflags` -lGL -I/usr/include/lua50 -I/usr/include/GL
endif

pong: engine
	./engine pong.lua

engine: engine.c Makefile
	$(CC) engine.c SDLMain.m $(LIBS) -o $(BIN)

test: buildtest
	clear
	./$(TESTBIN)

buildtest: test.c Makefile
	clear
	$(CC) test.c $(LIBS) -o $(TESTBIN)

clean:
	rm -f $(BIN) $(TESTBIN)

