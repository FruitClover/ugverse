CC = gcc
CFLAGS = -O2 -Wall -Wextra -Werror

SOURCE = src/main.c
OBJECTS = $(SOURCE:.c=.o)
EXECUTABLE = ugverse

# 
# Debug build settings
#

DEBUG_DIR = build/debug
DEBUG_EXECUTABLE = $(DEBUG_DIR)/$(EXECUTABLE)
DEBUG_OBJECTS = $(addprefix $(DEBUG_DIR)/, $(OBJECTS))
DEBUG_CFLAGS = -O0 -g3 -DDEBUG

#
# Release build settings
#
#
RELEASE_DIR = build/release
RELEASE_EXECUTABLE = $(RELEASE_DIR)/$(EXECUTABLE)
RELEASE_OBJECTS = $(addprefix $(RELEASE_DIR)/, $(OBJECTS))
RELEASE_CFLAGS = -O2 -g0 -DRELEASE



DIR_GUARD = @mkdir -p $(@D)



all: debug release



debug: $(DEBUG_EXECUTABLE)


$(DEBUG_EXECUTABLE): $(DEBUG_OBJECTS)
	$(DIR_GUARD)
	$(CC) $(CFLAGS) $(DEBUG_CFLAGS) -o $(DEBUG_EXECUTABLE) $^


$(DEBUG_DIR)/%.o: %.c
	$(DIR_GUARD)
	$(CC) -c $(CLFAGS) $(DEBUG_CFLAGS) -o $@  $<



release: $(RELEASE_EXECUTABLE)


$(RELEASE_EXECUTABLE): $(RELEASE_OBJECTS)
	$(DIR_GUARD)
	$(CC) $(CFLAGS) $(RELEASE_CFLAGS) -o $(RELEASE_EXECUTABLE) $^

$(RELEASE_DIR)/%.o: %.c
	$(DIR_GUARD)
	$(CC) -c $(CFLAGS) $(RELEASE_CFLAGS) -o $@ $<


remake: clean all

clean: 
	rm -f $(DEBUG_EXECUTABLE) $(DEBUG_OBJECTS) $(RELEASE_OBJECTS) $(RELEASE_EXECUTABLE)

