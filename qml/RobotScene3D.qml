import QtQuick
import QtQuick3D

Item {
    id: root

    readonly property real kPrimitiveSize: 100
    readonly property real axisLength: 1.20
    readonly property real axisRadius: 0.010
    readonly property real axisTipRadius: 0.025
    readonly property real axisLabelOffset: 0.08
    readonly property vector3d axisOrigin: Qt.vector3d(0, 0.06, 0)
    property var points: controller.framePoints

    View3D {
        id: view3d
        camera: camera3d
        anchors.fill: parent

        environment: SceneEnvironment {
            clearColor: "#F4F4F4"
            antialiasingMode: SceneEnvironment.MSAA
        }

        PerspectiveCamera {
            id: camera3d
            position: Qt.vector3d(1.5, 2.0, 3.0)
            rotation: Quaternion.lookAt(position, Qt.vector3d(-0.25, -0.02, 0.1))
            fieldOfView: 45
            clipNear: 0.01
            clipFar: 100
        }

        DirectionalLight {
            eulerRotation.x: -45
            eulerRotation.y: 30
            brightness: 1.2
        }

        DirectionalLight {
            eulerRotation.x: 60
            brightness: 0.4
        }

        Model {
            source: "#Cylinder"
            position: Qt.vector3d(0, -0.03, 0)
            scale: Qt.vector3d(0.50 / root.kPrimitiveSize,
                               0.06 / root.kPrimitiveSize,
                               0.50 / root.kPrimitiveSize)

            materials: PrincipledMaterial {
                baseColor: "#D0D0D0"
                roughness: 0.7
            }
        }

        // Мировые оси: X вправо, Y вглубь сцены, Z вверх.
        Node {
            id: worldAxes
            position: root.axisOrigin

            Node {
                readonly property vector3d direction: Qt.vector3d(1, 0, 0)
                position: direction.times(root.axisLength / 2)
                rotation: root.rotationFromY(direction)

                Model {
                    source: "#Cylinder"
                    scale: Qt.vector3d(root.axisRadius * 2 / root.kPrimitiveSize,
                                       root.axisLength / root.kPrimitiveSize,
                                       root.axisRadius * 2 / root.kPrimitiveSize)
                    materials: PrincipledMaterial {
                        baseColor: "#D32F2F"
                        roughness: 0.5
                    }
                }

                Model {
                    source: "#Sphere"
                    position: Qt.vector3d(0, root.axisLength / 2, 0)
                    scale: Qt.vector3d(root.axisTipRadius * 2 / root.kPrimitiveSize,
                                       root.axisTipRadius * 2 / root.kPrimitiveSize,
                                       root.axisTipRadius * 2 / root.kPrimitiveSize)
                    materials: PrincipledMaterial {
                        baseColor: "#D32F2F"
                        roughness: 0.5
                    }
                }
            }

            Node {
                readonly property vector3d direction: Qt.vector3d(0, 0, -1)
                position: direction.times(root.axisLength / 2)
                rotation: root.rotationFromY(direction)

                Model {
                    source: "#Cylinder"
                    scale: Qt.vector3d(root.axisRadius * 2 / root.kPrimitiveSize,
                                       root.axisLength / root.kPrimitiveSize,
                                       root.axisRadius * 2 / root.kPrimitiveSize)
                    materials: PrincipledMaterial {
                        baseColor: "#2E7D32"
                        roughness: 0.5
                    }
                }

                Model {
                    source: "#Sphere"
                    position: Qt.vector3d(0, root.axisLength / 2, 0)
                    scale: Qt.vector3d(root.axisTipRadius * 2 / root.kPrimitiveSize,
                                       root.axisTipRadius * 2 / root.kPrimitiveSize,
                                       root.axisTipRadius * 2 / root.kPrimitiveSize)
                    materials: PrincipledMaterial {
                        baseColor: "#2E7D32"
                        roughness: 0.5
                    }
                }
            }

            Node {
                readonly property vector3d direction: Qt.vector3d(0, 1, 0)
                position: direction.times(root.axisLength / 2)
                rotation: root.rotationFromY(direction)

                Model {
                    source: "#Cylinder"
                    scale: Qt.vector3d(root.axisRadius * 2 / root.kPrimitiveSize,
                                       root.axisLength / root.kPrimitiveSize,
                                       root.axisRadius * 2 / root.kPrimitiveSize)
                    materials: PrincipledMaterial {
                        baseColor: "#1565C0"
                        roughness: 0.5
                    }
                }

                Model {
                    source: "#Sphere"
                    position: Qt.vector3d(0, root.axisLength / 2, 0)
                    scale: Qt.vector3d(root.axisTipRadius * 2 / root.kPrimitiveSize,
                                       root.axisTipRadius * 2 / root.kPrimitiveSize,
                                       root.axisTipRadius * 2 / root.kPrimitiveSize)
                    materials: PrincipledMaterial {
                        baseColor: "#1565C0"
                        roughness: 0.5
                    }
                }
            }
        }

        Repeater3D {
            model: root.points.length - 1

            delegate: Node {
                readonly property vector3d startPoint: root.points[index]
                readonly property vector3d endPoint: root.points[index + 1]
                readonly property vector3d direction: endPoint.minus(startPoint)

                position: startPoint.plus(direction.times(0.5))
                rotation: root.rotationFromY(direction)

                Model {
                    source: "#Cylinder"
                    scale: Qt.vector3d(0.06 / root.kPrimitiveSize,
                                       direction.length() / root.kPrimitiveSize,
                                       0.06 / root.kPrimitiveSize)

                    materials: PrincipledMaterial {
                        baseColor: "#2F6FED"
                        roughness: 0.4
                    }
                }
            }
        }

        Repeater3D {
            model: root.points.length

            delegate: Model {
                source: "#Sphere"
                position: root.points[index]
                scale: Qt.vector3d(0.07 / root.kPrimitiveSize,
                                   0.07 / root.kPrimitiveSize,
                                   0.07 / root.kPrimitiveSize)

                materials: PrincipledMaterial {
                    baseColor: index === root.points.length - 1 ? "#E8590C" : "#111111"
                }
            }
        }
    }

    Text {
        readonly property vector3d anchor: {
            view3d.width
            view3d.height
            return view3d.mapFrom3DScene(Qt.vector3d(root.axisOrigin.x + root.axisLength + root.axisLabelOffset,
                                                      root.axisOrigin.y,
                                                      root.axisOrigin.z))
        }
        x: anchor.x + 4
        y: anchor.y - height / 2
        text: "X"
        color: "#D32F2F"
        style: Text.Outline
        styleColor: "#FFFFFF"
        font.bold: true
        font.pixelSize: 18
    }

    Text {
        readonly property vector3d anchor: {
            view3d.width
            view3d.height
            return view3d.mapFrom3DScene(Qt.vector3d(root.axisOrigin.x,
                                                      root.axisOrigin.y,
                                                      root.axisOrigin.z - root.axisLength - root.axisLabelOffset))
        }
        x: anchor.x + 4
        y: anchor.y - height / 2
        text: "Y"
        color: "#2E7D32"
        style: Text.Outline
        styleColor: "#FFFFFF"
        font.bold: true
        font.pixelSize: 18
    }

    Text {
        readonly property vector3d anchor: {
            view3d.width
            view3d.height
            return view3d.mapFrom3DScene(Qt.vector3d(root.axisOrigin.x,
                                                      root.axisOrigin.y + root.axisLength + root.axisLabelOffset,
                                                      root.axisOrigin.z))
        }
        x: anchor.x + 4
        y: anchor.y - height / 2
        text: "Z"
        color: "#1565C0"
        style: Text.Outline
        styleColor: "#FFFFFF"
        font.bold: true
        font.pixelSize: 18
    }

    function rotationFromY(direction) {
        const length = direction.length()

        if (length < 1e-9)
            return Qt.quaternion(1, 0, 0, 0)

        const dot = Math.max(-1, Math.min(1, Qt.vector3d(0, 1, 0).dotProduct(direction) / length))
        const axis = Qt.vector3d(0, 1, 0).crossProduct(direction)

        if (axis.length() < 1e-9) {
            return dot > 0
                ? Qt.quaternion(1, 0, 0, 0)
                : Quaternion.fromAxisAndAngle(Qt.vector3d(1, 0, 0), 180)
        }

        return Quaternion.fromAxisAndAngle(axis.normalized(), Math.acos(dot) * 180 / Math.PI)
    }
}
