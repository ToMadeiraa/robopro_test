import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

ApplicationWindow {
    id: window
    width: 1100
    height: 680
    minimumWidth: 900
    minimumHeight: 620
    visible: true
    title: qsTr("Robot TCP")
    color: "#F4F4F4"
    readonly property int baseFontSize: 17

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.preferredWidth: 320
            Layout.fillHeight: true
            color: "#FFFFFF"

            Column {
                id: controls
                anchors.fill: parent
                anchors.margins: 20
                spacing: 12

                Text {
                    text: qsTr("Модель")
                    font.bold: true
                    font.pixelSize: window.baseFontSize
                }

                ComboBox {
                    width: controls.width
                    font.pixelSize: window.baseFontSize
                    model: controller.modelNames
                    currentIndex: controller.currentModelIndex
                    onActivated: (index) => controller.currentModelIndex = index
                }

                Column {
                    width: controls.width
                    spacing: 10

                    Repeater {
                        model: controller.joints

                        delegate: Column {
                            width: parent.width
                            spacing: 4

                            RowLayout {
                                width: parent.width

                                Text {
                                    text: model.jointName
                                    font.pixelSize: window.baseFontSize
                                }

                                Item {
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: Number(model.angleDeg).toFixed(1) + "°"
                                    color: "#555555"
                                    font.pixelSize: window.baseFontSize
                                }
                            }

                            Slider {
                                width: parent.width
                                from: -180
                                to: 180
                                stepSize: 0.5
                                value: model.angleDeg
                                onMoved: controller.setJointAngle(index, value)
                            }
                        }
                    }
                }

                Column {
                    width: controls.width
                    spacing: 2

                    Text {
                        text: qsTr("TCP")
                        font.bold: true
                        font.pixelSize: window.baseFontSize
                    }

                    Text {
                        text: "x = " + Number(controller.tcpPosition.x).toFixed(4)
                        font.family: "monospace"
                        font.pixelSize: window.baseFontSize
                    }

                    Text {
                        text: "y = " + Number(controller.tcpPosition.y).toFixed(4)
                        font.family: "monospace"
                        font.pixelSize: window.baseFontSize
                    }

                    Text {
                        text: "z = " + Number(controller.tcpPosition.z).toFixed(4)
                        font.family: "monospace"
                        font.pixelSize: window.baseFontSize
                    }
                }
            }
        }

        RobotScene3D {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
