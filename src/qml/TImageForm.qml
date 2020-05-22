import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls.Material 2.14

import "../javascript/jsproject.js" as Project


Item {
    id:root
    width:parent.width-16
    anchors.horizontalCenter: parent.horizontalCenter


    height: glForm.implicitHeight

    function setCurrentFrameType(type) {
        switch(type) {
            case "noFrame":
                frameType.currentIndex = 0;
                break;
            case "french":
                frameType.currentIndex = 1;
                break;
            case "italian":
                frameType.currentIndex = 2;
                break;
            case "square":
                frameType.currentIndex = 3;
                break;

        }
    }

    function setCurrentFormat(format) {
        switch(format) {
            case "16_9":
                frenchFormat.currentIndex = 0;
                break;
            case "3_2":
                frenchFormat.currentIndex = 1;
                break;
            case "4_3":
                frenchFormat.currentIndex = 2;
                break;

        }
    }

    function setCurrentSize(size) {
        imageSize.value = size;
    }

    function setCurrentHorizontal(horizontal) {
        imageHorizontal.value = horizontal;
    }

    function setCurrentVertical(vertical) {
        imageVertical.value = vertical;
    }

    property bool formEnabled: false

    signal newFrameType(string frameType)
    signal newFormat(string format)
    signal newSize(int size)
    signal newHorizontal(int horizontal)
    signal newVertical(int vertical)

    GridLayout {
        id:glForm
        columns: 2
        width:parent.width
        rowSpacing: 8
        columnSpacing: 8

        Label {
            text: qsTr("Frame format")
        }
        ComboBox {
            id: frameType
            Layout.fillWidth: true
            enabled: root.formEnabled
            model: [qsTr("No frame"), qsTr("French"), qsTr("Italian"), qsTr("Square")]

            onCurrentIndexChanged: {
                switch(currentIndex) {
                    case 0:
                        root.newFrameType("noFrame");
                        break;
                    case 1:
                        root.newFrameType("french");
                        break;
                    case 2:
                        root.newFrameType("italian");
                        break;
                    case 3:
                        root.newFrameType("square");
                        break;

                }

            }
        }

        Label {
            text: qsTr("Format")
            visible: frameType.currentIndex > 0 && frameType.currentIndex < 3
        }

        ComboBox {
            id: frenchFormat
            Layout.fillWidth: true
            enabled: root.formEnabled
            visible: frameType.currentIndex > 0 && frameType.currentIndex < 3
            model: [qsTr("16/9"), qsTr("3/2"), qsTr("4/3")]

            onCurrentIndexChanged: {
                switch(currentIndex) {
                    case 0:
                        root.newFormat("16_9");
                        break;
                    case 1:
                        root.newFormat("3_2");
                        break;
                    case 2:
                        root.newFormat("4_3");
                        break;

                }

            }
        }

        Label {
            text: qsTr("Size")
        }

        Slider {
            enabled: root.formEnabled
            id:imageSize
            from: 10
            value: 80
            to: 100
            Layout.fillWidth: true
            stepSize: 1

            onValueChanged: {
                newSize(value);
            }

            Text {
                text: imageSize.value + " %"
                color: "#FFFFFF"
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent

                    onDoubleClicked: {
                        imageSize.value = 80;
                        mouse.accepted = true
                    }

                }
            }


        }

        Label {
            text: qsTr("Horizontal")
        }

        Slider {
            enabled: root.formEnabled
            id:imageHorizontal
            from: flickable.currentSelectImg ? flickable.currentSelectImg.width/2*-1 : 0
            value: 0
            to: flickable.currentSelectImg ? flickable.currentSelectImg.width/2 : 0
            Layout.fillWidth: true

            stepSize: 1

            onValueChanged: {
                newHorizontal(value);
            }

            Text {
                text: imageHorizontal.value
                color: "#FFFFFF"
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent

                    onDoubleClicked: {
                        imageHorizontal.value = 0;
                        mouse.accepted = true
                    }
                }
            }


        }

        Label {
            text: qsTr("Vertical")
        }

        Slider {
            enabled: root.formEnabled
            id:imageVertical
            from: flickable.currentSelectImg ? flickable.currentSelectImg.height/2*-1 : 0
            value: 0
            to: flickable.currentSelectImg ? flickable.currentSelectImg.height/2 : 0
            Layout.fillWidth: true

            stepSize: 1

            onValueChanged: {
                newVertical(value);
            }

            Text {
                text: imageVertical.value
                color: "#FFFFFF"
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent

                    onDoubleClicked: {
                        imageVertical.value = 0;
                        mouse.accepted = true
                    }

                }
            }




        }

    }

}
