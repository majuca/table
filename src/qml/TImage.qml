import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14

Rectangle {
    id:root
    property alias source: image.source
    property bool selected: false
    property alias imgHeight: image.sourceSize.height

    width: image.implicitWidth + 8
    height: image.implicitHeight + 8

    signal clicked()

    color: selected ? "grey" : "transparent"

    onXChanged: {
        console.debug(x,y)
    }

    onYChanged: {
        console.debug(x,y )

    }

    MouseArea {
        id: mouseArea
        property bool held: false
        anchors.fill: parent

        onPressed: {
            console.debug("pressed");
        }

        onReleased: {
            console.debug("release");
            root.selected =! root.selected
            root.clicked()
        }

        onClicked: {
            console.debug("clicked");

        }

        Image {
            id:image
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectFit            
            sourceSize.height: root.height
        }
    }
}


