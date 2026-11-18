Стек: **C++17, Qt 6 (Quick/QML, Quick 3D), CMake**\
Проверялось на **Windows** и **VM Linux Ubuntu 22.04**\
На **Windows** работает из QtCreator (Qt 6.11, MinGW), либо:

```powershell
cmake -S . -B build -G Ninja `
  -DCMAKE_BUILD_TYPE=Release `
  -DCMAKE_PREFIX_PATH=<путь до Qt>/6.11.1/mingw_64 `
  -DCMAKE_CXX_COMPILER=<путь до Qt>/Tools/mingw1310_64/bin/g++.exe `
  -DCMAKE_MAKE_PROGRAM=<путь до Qt>/Tools/Ninja/ninja.exe
cmake --build build
```

На **Linux** специальный скрипт для подтягивания зависимостей в **scripts/install_dependencies_ubuntu.sh**\
Или вручную:
```bash
    build-essential
    cmake
    ninja-build
    pkg-config
    qt6-base-dev
    qt6-declarative-dev
    qt6-quick3d-dev
    qt6-quick3d-dev-tools
    qml6-module-qtquick
    qml6-module-qtquick-controls
    qml6-module-qtquick-templates
    qml6-module-qtquick-layouts
    qml6-module-qtquick-window
    qml6-module-qtqml-workerscript
    qml6-module-quick3d
    libgl1-mesa-dev
```	
	
Доп. пакеты для запуска на ВМ:
```bash
	libxkbcommon-dev
    libxkbcommon-x11-dev
	qt6-shadertools-dev или libqt6shadertools6-dev
	vulkan-sdk
	libvulkan-dev
	vulkan-tools
```	

Компиляция и запуск:
```bash
chmod +x scripts/install_dependencies_ubuntu.sh
./scripts/install_dependencies_ubuntu.sh
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build -j"$(nproc)"
./build/robot_tcp
```

### Пример работы в example.mp4