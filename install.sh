#!/bin/bash
# install.sh - скрипт установки для друга

echo "🐧 Установка MyApp..."
echo ""

# Проверяем, какая у нас ОС
OS=$(uname -s)
ARCH=$(uname -m)

echo "Обнаружена система: $OS $ARCH"
echo ""

# Скачиваем нужную версию
if [[ "$OS" == "Linux" ]]; then
    if [[ "$ARCH" == "x86_64" ]]; then
        echo "Скачиваю версию для Linux x64..."
        curl -L -o myapp https://github.com/ВАШ_НИК/myapp/releases/latest/download/myapp-linux-x64
    elif [[ "$ARCH" == "aarch64" ]] || [[ "$ARCH" == "arm64" ]]; then
        echo "Скачиваю версию для Linux ARM..."
        curl -L -o myapp https://github.com/ВАШ_НИК/myapp/releases/latest/download/myapp-linux-arm
    else
        echo "❌ Неподдерживаемая архитектура: $ARCH"
        exit 1
    fi
elif [[ "$OS" == "Darwin" ]]; then  # macOS
    echo "Скачиваю версию для macOS..."
    curl -L -o myapp https://github.com/ВАШ_НИК/myapp/releases/latest/download/myapp-macos
elif [[ "$OS" == "MINGW"* ]] || [[ "$OS" == "CYGWIN"* ]] || [[ "$OS" == "MSYS"* ]]; then
    echo "Скачиваю версию для Windows..."
    curl -L -o myapp.exe https://github.com/ВАШ_НИК/myapp/releases/latest/download/myapp-windows.exe
    echo "✅ Скачано myapp.exe"
    echo "Запускайте: myapp.exe --help"
    exit 0
else
    echo "❌ Неподдерживаемая ОС: $OS"
    exit 1
fi

# Делаем исполняемым
chmod +x myapp

# Спрашиваем, куда установить
echo ""
echo "Куда установить программу?"
echo "1) Текущая папка (просто запускать как ./myapp)"
echo "2) /usr/local/bin (глобально, для всех пользователей) - нужен sudo"
echo "3) ~/.local/bin (только для вас)"
echo ""
read -p "Выберите вариант [1/2/3]: " choice

case $choice in
    1)
        echo "✅ Готово! Запускайте: ./myapp"
        ;;
    2)
        sudo mv myapp /usr/local/bin/
        echo "✅ Установлено! Запускайте: myapp"
        ;;
    3)
        mkdir -p ~/.local/bin
        mv myapp ~/.local/bin/
        echo "✅ Установлено! Запускайте: myapp"
        echo "Добавьте ~/.local/bin в PATH, если еще не сделали:"
        echo 'export PATH="$HOME/.local/bin:$PATH"'
        ;;
    *)
        echo "⚠️  Оставлено в текущей папке. Запускайте: ./myapp"
        ;;
esac

echo ""
echo "🎉 Проверьте работу:"
if [[ "$choice" == "1" ]]; then
    ./myapp --version
else
    myapp --version
fi