Стек: **C++17, Qt 6 (Quick/QML, Quick 3D), CMake**


На **Windows** работает из QtCreator (Qt 6.11, MinGW), либо:

```powershell
cmake -S . -B build -G Ninja `
  -DCMAKE_BUILD_TYPE=Release `
  -DCMAKE_PREFIX_PATH=<путь до Qt>/6.11.1/mingw_64 `
  -DCMAKE_CXX_COMPILER=<путь до Qt>/Tools/mingw1310_64/bin/g++.exe `
  -DCMAKE_MAKE_PROGRAM=<путь до Qt>/Tools/Ninja/ninja.exe
cmake --build build
```

На **Linux** специальный скрипт для подтягивания зависимостей в scripts/install_dependencies_ubuntu.sh

Компиляция и запуск:
```bash
chmod +x scripts/install_dependencies_ubuntu.sh
./scripts/install_dependencies_ubuntu.sh
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build -j"$(nproc)"
./build/robot_tcp
```


Пример работы:

<video width="640" height="360" controls>
  <source src="путь_к_видео.mp4" type="video/mp4">
  Ваш браузер не поддерживает тег video.
</video>