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
                    onCurrentSelectImgChanged: {

                        if(currentSelectImg) {
                            imageForm.setCurrentFrameType(currentSelectImg.frameType);
                            imageForm.setCurrentFormat(currentSelectImg.format);
                            imageForm.setCurrentSize(currentSelectImg.size);
                            imageForm.setCurrentHorizontal(currentSelectImg.horizontal);
                            imageForm.setCurrentVertical(currentSelectImg.vertical);

                        } else {
                            imageForm.setCurrentFrameType("noFrame");
                            imageForm.setCurrentFormat("16_9");
                            imageForm.setCurrentSize(80);
                        }
                    }
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

        Column {

            anchors.fill: parent
            spacing: 16

            TProjectForm {
                id:projectForm

            }

            TImageForm {
                id:imageForm
                formEnabled: flickable.selected

                onNewFrameType: {
                    if(flickable.currentSelectImg && flickable.currentSelectImg.frameType !== frameType ) {
                        flickable.currentSelectImg.frameType = frameType;
                        project.isModified = true
                    }
                }

                onNewFormat: {
                    if(flickable.currentSelectImg && flickable.currentSelectImg.format !== format ) {
                        flickable.currentSelectImg.format = format;
                        project.isModified = true
                    }
                }

                onNewSize: {
                    if(flickable.currentSelectImg && flickable.currentSelectImg.size !== size ) {
                        flickable.currentSelectImg.size = size;
                        project.isModified = true
                    }
                }

                onNewHorizontal: {
                    if(flickable.currentSelectImg && flickable.currentSelectImg.horizontal !== horizontal ) {
                        flickable.currentSelectImg.horizontal = horizontal;
                        project.isModified = true
                    }
                }

                onNewVertical: {
                    if(flickable.currentSelectImg && flickable.currentSelectImg.vertical !== vertical ) {
                        flickable.currentSelectImg.vertical = vertical;
                        project.isModified = true
                    }
                }
            }
        }

    }

}
