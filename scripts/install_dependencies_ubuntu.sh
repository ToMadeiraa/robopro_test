#!/usr/bin/env bash
#
# Устанавливает зависимости сборки и запуска Robot TCP на Ubuntu.
# Рассчитан на Ubuntu 22.04 LTS (Qt 6.2.4) и 24.04 LTS (Qt 6.4.2).

set -euo pipefail

if [[ ! -r /etc/os-release ]]; then
    echo "Не удалось прочитать /etc/os-release." >&2
    exit 1
fi

# shellcheck disable=SC1091
. /etc/os-release

if [[ "${ID:-}" != "ubuntu" ]]; then
    echo "Скрипт рассчитан на Ubuntu, обнаружено: ${PRETTY_NAME:-неизвестно}." >&2
    exit 1
fi

case "${VERSION_ID:-}" in
    22.04|24.04)
        ;;
    *)
        echo "Предупреждение: скрипт проверен на 22.04 и 24.04, обнаружено ${VERSION_ID:-?}." >&2
        ;;
esac

if [[ "${EUID}" -ne 0 ]]; then
    if ! command -v sudo >/dev/null 2>&1; then
        echo "Нужны права root: запустите скрипт через sudo." >&2
        exit 1
    fi
    SUDO="sudo"
else
    SUDO=""
fi

echo "Обновление списка пакетов..."
${SUDO} apt-get update

PACKAGES=(
    build-essential
    cmake
    ninja-build
    pkg-config
    qt6-base-dev
    qt6-declarative-dev
    qt6-quick3d-dev
    qt6-quick3d-dev-tools
    libxkbcommon-dev
    libxkbcommon-x11-dev
    qml6-module-qtquick
    qml6-module-qtquick-controls
    qml6-module-qtquick-templates
    qml6-module-qtquick-layouts
    qml6-module-qtquick-window
    qml6-module-qtqml-workerscript
    qml6-module-quick3d
    libgl1-mesa-dev
)

# Qt 6 Shader Tools: в Ubuntu 22.04 пакет называется libqt6shadertools6-dev.
if apt-cache show qt6-shadertools-dev >/dev/null 2>&1; then
    PACKAGES+=(qt6-shadertools-dev)
elif apt-cache show libqt6shadertools6-dev >/dev/null 2>&1; then
    PACKAGES+=(libqt6shadertools6-dev)
else
    echo "Предупреждение: Shader Tools для Qt 6 не найден, пропускаю." >&2
fi

# В Ubuntu 22.04 метапакета vulkan-sdk нет — ставим компоненты SDK.
if apt-cache show vulkan-sdk >/dev/null 2>&1; then
    PACKAGES+=(vulkan-sdk)
elif apt-cache show libvulkan-dev >/dev/null 2>&1; then
    PACKAGES+=(libvulkan-dev)
    if apt-cache show vulkan-tools >/dev/null 2>&1; then
        PACKAGES+=(vulkan-tools)
    fi
else
    echo "Предупреждение: Vulkan SDK не найден, пропускаю." >&2
fi

echo "Установка компилятора, CMake, Ninja и Qt 6..."
${SUDO} env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    "${PACKAGES[@]}"

if command -v qmake6 >/dev/null 2>&1; then
    echo "Установленная версия Qt: $(qmake6 -query QT_VERSION)"
fi

echo
echo "Готово. Сборка:"
echo "  cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release"
echo "  cmake --build build -j\"\$(nproc)\""
echo "  ./build/robot_tcp"
