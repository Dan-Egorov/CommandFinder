#!/bin/bash
# install.sh

echo "🐧 Установка fnd..."
echo ""

OS=$(uname -s)
ARCH=$(uname -m)

echo "Обнаружена система: $OS $ARCH"
echo ""

if [[ "$OS" == "Darwin" ]]; then  # macOS
    echo "Скачиваю версию для macOS..."
    curl -L -o fnd https://github.com/Dan-Egorov/CommandFinder/raw/5876828320f137d0e19bf0bf7712557c49e15f8c/fnd
elif [[ "$OS" == "MINGW"* ]] || [[ "$OS" == "CYGWIN"* ]] || [[ "$OS" == "MSYS"* ]]; then
    echo "Скачиваю версию для Windows..."
    echo "✅ Скачано fnd.exe"
    echo "Запускайте: fnd.exe --help"
    exit 0
else
    echo "❌ Неподдерживаемая ОС: $OS"
    exit 1
fi

# исполняемый
chmod +x fnd

echo ""
echo "Куда установить программу?"
echo "1) Текущая папка (просто запускать как ./fnd)"
echo "2) /usr/local/bin (глобально, для всех пользователей) - нужен sudo"
echo "3) ~/.local/bin (только для вас)"
echo ""
read -p "Выберите вариант [1/2/3]: " choice

case $choice in
    1)
        echo "✅ Готово! Запускайте: ./fnd"
        ;;
    2)
        sudo mv fnd /usr/local/bin/
        echo "✅ Установлено! Запускайте: fnd"
        ;;
    3)
        mkdir -p ~/.local/bin
        mv fnd ~/.local/bin/
        echo "✅ Установлено! Запускайте: fnd"
        echo "Добавьте ~/.local/bin в PATH, если еще не сделали:"
        echo 'export PATH="$HOME/.local/bin:$PATH"'
        ;;
    *)
        echo "⚠️  Оставлено в текущей папке. Запускайте: ./fnd"
        ;;
esac

echo ""
echo "🎉 Проверьте работу:"
if [[ "$choice" == "1" ]]; then
    ./fnd -h
else
    fnd -h
fi