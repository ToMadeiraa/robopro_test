cmake_minimum_required(VERSION 3.22)

project(robot_tcp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Core Gui Qml Quick Quick3D)

qt_add_executable(robot_tcp
    src/main.cpp
    src/core/DhLink.h
    src/core/ForwardKinematics.cpp
    src/core/ForwardKinematics.h
    src/core/Matrix4.cpp
    src/core/Matrix4.h
    src/core/RobotModel.cpp
    src/core/RobotModel.h
    src/core/RobotModelCatalog.cpp
    src/core/RobotModelCatalog.h
    src/core/Vector3.h
    src/app/JointListModel.cpp
    src/app/JointListModel.h
    src/app/RobotController.cpp
    src/app/RobotController.h
)

target_include_directories(robot_tcp PRIVATE src)

qt_add_resources(robot_tcp "qml_resources"
    PREFIX "/"
    FILES
        qml/Main.qml
        qml/RobotScene3D.qml
)

target_link_libraries(robot_tcp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::Quick3D
)

if (WIN32)
    set_target_properties(robot_tcp PROPERTIES WIN32_EXECUTABLE TRUE)
endif()

if (MSVC)
    target_compile_options(robot_tcp PRIVATE /W4)
else()
    target_compile_options(robot_tcp PRIVATE -Wall -Wextra -Wpedantic)
endif()

install(TARGETS robot_tcp RUNTIME DESTINATION bin)
