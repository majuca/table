import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14

Rectangle {
    id:root
    property alias source: image.source
    property bool selected: false

    property string frameType: "noFrame"

    color: selected ? "grey" : "transparent"

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


    Drag.active: selected

    onFrameTypeChanged: {
        switch(frameType) {
            case "noFrame":
                image.setNoFrame();
                break;
            case "french":
                image.setFrenchType()
                break;
            case "italian":
                image.setItalianType()
                break;
        }
    }

    Rectangle {
        id:framRect
        color:"#FFFFFF"
        anchors.centerIn: parent

        Image {
            id:image
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            sourceSize.height: 100
            sourceSize.width: 100

            Component.onCompleted: {
                switch(frameType) {
                    case "noFrame":
                        setNoFrame();
                        break;
                    case "french":
                        setFrenchType()
                        break;
                    case "italian":
                        setItalianType()
                        break;
                }
            }



            function setNoFrame() {
                if(image.sourceSize.width>image.sourceSize.height) {
                    image.sourceSize.width  = 200
                }
                if(image.sourceSize.width<=image.sourceSize.height) {
                    image.sourceSize.height  = 200
                }

                framRect.width = image.width
                framRect.height = image.height
                root.width = image.width + 8
                root.height = image.height + 8

            }

            function setFrenchType() {
                if(image.sourceSize.width>image.sourceSize.height) {
                    image.sourceSize.width  = 200
                }
                if(image.sourceSize.width<=image.sourceSize.height) {
                    image.sourceSize.height  = 200
                }

                framRect.width = image.width + 40
                framRect.height = image.height + 140

                root.width = image.width + 40 + 8
                root.height = image.height  + 140 + 8

            }

            function setItalianType() {
                if(image.sourceSize.width>image.sourceSize.height) {
                    image.sourceSize.width  = 200
                }
                if(image.sourceSize.width<=image.sourceSize.height) {
                    image.sourceSize.height  = 200
                }

                framRect.width = image.width + 140
                framRect.height = image.height + 40

                root.width = image.width + 140 + 8
                root.height = image.height  + 40 + 8

            }
        }
    }

    MouseArea {
        id: mouseArea
        property bool held: false
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        drag.target: selected ? parent : undefined
        drag.minimumX: 0
        drag.minimumY: 0

        onPressed: {
            root.selected = true

            if(root.selected) {
                flickable.setSelected(root);
            } else {
                flickable.setSelected(null);
            }
        }
    }
}


