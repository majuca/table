import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14

Rectangle {
    id:root
    property alias source: image.source
    property bool selected: false

    signal clicked()

    color: selected ? "grey" : "transparent"

    width: image.implicitWidth + 8

    MouseArea {
        id: mouseArea
        property bool held: false
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        onReleased: {
            root.clicked()
        }

        Image {
            id:image
            fillMode: Image.PreserveAspectFit
            sourceSize.height: root.height - 8
            anchors.centerIn: parent
        }
    }
}


