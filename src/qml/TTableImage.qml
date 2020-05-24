import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14

Rectangle {
    id:root
    property alias source: image.source
    property bool selected: false

    property string frameType: "noFrame"
    property string format: "4_3"
    property int size: 80
    property int horizontal: 0
    property int vertical: 0

    color: selected ? "grey" : "transparent"

    onXChanged: {
        flickable.resize()
        if(selected) {
            project.isModified = true;
        }
    }

    onYChanged: {
        flickable.resize()
        if(selected) {
            project.isModified = true;
        }
    }


    Drag.active: selected

    onFrameTypeChanged: {
        image.setFormat()
    }

    onFormatChanged: {
        image.setFormat()
    }

    onSizeChanged: {
        image.setFormat()
    }

    onHorizontalChanged: {
        image.setFormat()
    }

    onVerticalChanged: {
        image.setFormat()
    }



    Rectangle {
        id:framRect
        color:"#FFFFFF"
        anchors.centerIn: parent

        clip: true

        Image {
            id:image
            fillMode: Image.PreserveAspectFit
            sourceSize.height: 100
            sourceSize.width: 100

            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: root.vertical

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: root.horizontal


            Component.onCompleted: {
                image.setFormat();
            }


            function setFormat() {
                var w = 0;
                var h = 0;
                switch(root.frameType) {
                    case "noFrame":
                        if(image.width>image.height) {
                            image.sourceSize.width  = 300 * (root.size/100)
                        }
                        if(image.width<=image.height) {
                            image.sourceSize.height  = 300 * (root.size/100)
                        }
                        framRect.width = image.width
                        framRect.height = image.height
                        root.width = image.width + 8
                        root.height = image.height + 8

                        break;
                    case "french":
                        switch(format) {
                            case "16_9":
                                w = 225;
                                h = 400;
                                break;
                            case "3_2":
                                w = 267;
                                h = 400;
                                break;
                            case "4_3":
                                w = 300
                                h = 400
                                break;
                        }

                        framRect.width = w;
                        framRect.height = h;

                        root.width = w + 8;
                        root.height = h + 8;

                        image.sourceSize.height = undefined
                        image.sourceSize.width  = framRect.width * (root.size/100)


                        break;
                    case "italian":
                        switch(format) {
                            case "16_9":
                                w = 400;
                                h = 225;
                                break;
                            case "3_2":
                                w = 400;
                                h = 267;
                                break;
                            case "4_3":
                                w = 400
                                h = 300
                                break;
                        }

                        framRect.width = w;
                        framRect.height = h;

                        root.width = w + 8;
                        root.height = h + 8;

                        image.sourceSize.width = undefined
                        image.sourceSize.height  = framRect.height * (root.size/100)
                        break;
                    case "square":

                        framRect.width = 300;
                        framRect.height = 300;
                        root.width = 300 + 8;
                        root.height = 300 + 8;

                        if(image.width>image.height) {
                            image.sourceSize.height = undefined
                            image.sourceSize.width  = framRect.width * (root.size/100)
                        }
                        if(image.width<=image.height) {
                            image.sourceSize.width = undefined
                            image.sourceSize.height  = framRect.height * (root.size/100)
                        }
                        break;
                }
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


