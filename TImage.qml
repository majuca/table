import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14

Rectangle {
    id:root
    property alias source: image.source
    property bool selected: false

    width: image.implicitWidth + 8
    height: image.implicitHeight + 8

    signal clicked()

    color: selected || mouseArea.containsMouse ? "grey" : "transparent"

    Image {
        id:image
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        sourceSize.width: 200

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled:true
            onClicked: {
                root.clicked()
                root.selected =! root.selected
            }
        }
    }

}
