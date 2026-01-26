TARGET = fnd
CC = gcc
CFLAGS = -I./src
SRC_DIR = src
OBJ_DIR = obj
SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES = $(SRC_FILES:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

all: $(TARGET)

$(TARGET): $(OBJ_FILES)
	$(CC) $(CFLAGS) $^ -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

install: $(TARGET)
	@echo "Установка в /usr/local/bin..."
	sudo cp $(TARGET) /usr/local/bin/
	@echo "Установлено! Теперь можно запускать: myapp"

uninstall:
	@echo "Удаление из /usr/local/bin..."
	sudo rm -f /usr/local/bin/$(TARGET)
	@echo "Удалено"
