import QtQuick 2.0
import QtQuick.Controls 2.14
import Qt.labs.platform 1.1
import "../javascript/jsproject.js" as Project


Row {
    anchors.fill: parent
    spacing: 16
    ListView {
        id:listView
        width: parent.width - 80 - 16
        height: parent.height
        orientation: ListView.Horizontal
        spacing: 8
        clip:true
        focus: true
        boundsBehavior:Flickable.StopAtBounds
        model: []

        property bool selected: false

        property real xPosition: 0

        delegate: TImage {
            anchors.verticalCenter: parent.verticalCenter
            source:modelData.source
            selected: modelData.selected
            height: parent.height - 32
            onClicked: {
                listView.xPosition = listView.contentX;
                var d = listView.model;
                d[index].selected = !selected;
                listView.model = d;
            }          
        }

        onModelChanged: {
            contentX = xPosition;

            if(listView.model) {

                listView.selected = false;
                for(var i=0; i<listView.model.length; i++) {
                    if(listView.model[i].selected) {
                       listView.selected = true;
                    }
                }
            }

        }

        ScrollBar.horizontal: ScrollBar {}

        Component.onCompleted: {
            Project.setListView(listView);
        }

        Connections {
            target: project
            onIsOpenChanged: {
                if(!project.isOpen) {
                    listView.model = [];
                }
            }
        }
    }

    Column {
        width: 80
        height: parent.height

        Button {
            icon.name:qsTr("Up")
            icon.source: "../image/angle-double-up-solid.svg"
            icon.height: 16
            icon.width: 12
            enabled: listView.selected

            onClicked: {
                var list = [];
                var x = 10;
                var y = 10;
                for(var i=0; i<listView.model.length; i++) {
                    if(!listView.model[i].selected) {
                        list.push(listView.model[i])
                    } else {                        
                        var component = Qt.createComponent("TTableImage.qml")
                        if (component.status === Component.Ready) {
                            var obj = component.createObject(flickable.contentItem,{
                                                       "source":listView.model[i].source,
                                                       "x":x,
                                                       "y":y,
                                                      });

                            Project.flickableImage.push({"obj":obj,"cmp":component});
                            x+=20;
                            y+=20;
                        } else {
                            console.debug("Component not ready")
                        }
                    }
                }

                project.isModified = true;
                listView.model = list;
                listView.selected = false;
            }
        }

        Button {
            icon.name: qsTr("New")
            icon.source: "../image/plus-solid.svg"
            icon.height: 16
            icon.width: 12
            enabled: project.isOpen || project.isModified
            onClicked: {
                fileDialog.open();
            }

            FileDialog {
                id: fileDialog
                title: "Please choose a file"
                folder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)
                fileMode:FileDialog.OpenFiles

                nameFilters: [ qsTr("Image files") + " (*.jpg *.jpeg *.png *.tiff)", qsTr("All files") + " (*)" ]
                onAccepted: {
                    var current = listView.model
                    var files = JSON.parse(JSON.stringify(fileDialog.currentFiles));
                    for(var i=0;i<files.length; i++) {
                        current.push({"source":files[i],"selected":false});
                        project.isModified = true;
                    }
                    listView.model = undefined;
                    listView.model = current;
                }
            }
        }
        Button {
            icon.name:qsTr("Delete")
            icon.source: "../image/trash-solid.svg"
            icon.height: 16
            icon.width: 12
            enabled: listView.selected
            onClicked: {
                var list = [];
                for(var i=0; i<listView.count; i++) {
                    var item = listView.itemAtIndex(i);
                    if(item && !item.selected) {
                        project.isModified = true;
                        list.push(listView.model[i])
                    }
                }

                listView.model = list;

            }
        }
    }
}
