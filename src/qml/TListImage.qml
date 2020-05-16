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
        model: []
        delegate: TImage {
            anchors.verticalCenter: parent.verticalCenter
            source:modelData
            onClicked: {
                listView.currentIndex = index;
            }
        }
        ScrollBar.horizontal: ScrollBar { }

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
            icon.name: qsTr("New")
            icon.source: "../image/plus-solid.svg"
            enabled: project.isOpen || project.isModified
            onClicked: {
                fileDialog.open();
            }

            FileDialog {
                id: fileDialog
                title: "Please choose a file"
                folder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)
                fileMode:FileDialog.OpenFiles

                nameFilters: [ qsTr("Image files (*.jpg *.jpeg *.png *.tiff)"), qsTr("All files (*)") ]
                onAccepted: {
                    var current = listView.model
                    var files = JSON.parse(JSON.stringify(fileDialog.currentFiles));
                    for(var i=0;i<files.length; i++) {
                        current.push(files[i]);
                        project.isModified = true;
                    }
                    listView.model = current;
                }
            }
        }
        Button {
            icon.name:qsTr("Delete")
            icon.source: "../image/trash-solid.svg"
            enabled: project.isOpen || project.isModified
            onClicked: {
                var list = [];
                for(var i=0; i<listView.count; i++) {
                    var item = listView.itemAtIndex(i);
                    if(!item.selected) {
                        project.isModified = true;
                        list.push(listView.model[i])
                    }
                }

                listView.model = list;

            }
        }
    }
}
