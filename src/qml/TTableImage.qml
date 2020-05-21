import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14

Rectangle {
    id:root
    property alias source: image.source
    property bool selected: false
    property bool isDragable: false

    signal clicked()

    color: selected ? "grey" : "transparent"

    width: image.implicitWidth + 8

    onXChanged: {
        if(parent === flickable.contentItem) {
            flickable.resize()
            if(selected) {
                project.isModified = true;
            }
        }
    }

    onYChanged: {
        if(parent === flickable.contentItem) {
            flickable.resize()
            if(selected) {
                project.isModified = true;
            }
        }
    }

    Drag.active: isDragable

    MouseArea {
        id: mouseArea
        property bool held: false
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        drag.target: isDragable ? parent : undefined
        drag.minimumX: 0
        drag.minimumY: 0

        onPressed: {
            if(root.parent === flickable.contentItem) {
                root.selected =! root.selected
                root.clicked()
                flickable.setSelected();
            }
        }

        onReleased: {
            if(root.parent !== flickable.contentItem) {
                root.selected =! root.selected
                root.clicked()
            }
        }


        Image {
            id:image
            fillMode: Image.PreserveAspectFit
            sourceSize.height: root.height - 8
            anchors.centerIn: parent
        }
    }
}


