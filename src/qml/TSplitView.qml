import QtQuick 2.0
import QtQuick.Controls 2.14
import "../javascript/jsproject.js" as Project

SplitView {
    id: split
    anchors.fill: parent
    orientation: Qt.Horizontal

    property var project: null

    //property var proxyDropArea: dropArea

    Item {
        SplitView.fillWidth: true

        SplitView {
            anchors.fill: parent
            orientation: Qt.Vertical


            Item {
                SplitView.fillHeight: true

                TTable {
                    id: flickable
                }

                Column {
                    width: 80
                    anchors.right: parent.right
                    anchors.top: parent.top

                    Button {
                        icon.name:qsTr("Delete")
                        icon.source: "../image/trash-solid.svg"
                        enabled: flickable.selected
                        onClicked: {
                            project.isModified = true;

                            for(var i=0; i<Project.flickableImage.length; i++) {
                                if(Project.flickableImage[i].obj) {
                                    if(Project.flickableImage[i].obj.selected) {
                                        Project.flickableImage[i].obj.destroy();
                                        Project.flickableImage[i].obj = null;
                                    }
                                }
                            }
                        }
                    }

                    Button {
                        icon.name:qsTr("Down")
                        icon.source: "../image/angle-double-down-solid.svg"
                        enabled: flickable.selected

                        onClicked: {
                            project.isModified = true;
                            var current = Project.listView.model
                            for(var i=0; i<Project.flickableImage.length; i++) {
                                if(Project.flickableImage[i].obj) {
                                    if(Project.flickableImage[i].obj.selected) {
                                        current.push(Project.flickableImage[i].obj.source);
                                        Project.flickableImage[i].obj.destroy();
                                        Project.flickableImage[i].obj = null;

                                    }
                                }
                            }

                            Project.listView.model = undefined;
                            Project.listView.model = current;
                        }
                    }

                }

            }

            Item {
                SplitView.minimumHeight : 0
                SplitView.preferredHeight: 250
                SplitView.maximumHeight: 300

                TListImage {

                }
            }
        }
     }

    Item {

        SplitView.minimumWidth: 0
        SplitView.preferredWidth: 300
        SplitView.maximumWidth: 400

        TProjectForm {
            id:projectForm

        }

    }

}
