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

        }
    }

    property bool formEnabled: false

    signal newFrameType(string frameType)

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
            model: [qsTr("No frame"), qsTr("French"), qsTr("Italian")]

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

                }

            }
        }
    }

}
