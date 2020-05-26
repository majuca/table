import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls.Material 2.14

import "../javascript/jsproject.js" as Project

Item {
    width:parent.width-16
    anchors.horizontalCenter: parent.horizontalCenter
    height: glForm.implicitHeight + 16 + button.implicitHeight + 16
    GridLayout {
        id:glForm
        columns: 2
        width:parent.width
        rowSpacing: 8
        columnSpacing: 8

        Label {
            text: qsTr("Name")
        }
        TextField {
            id: name
            Layout.fillWidth: true
            text: project ? project.projectName : ""
            enabled: project.isOpen || project.isModified
            onTextChanged: {
                if(text !== Project.getName()) {
                    Project.setName(text);
                }
            }

        }

        Label {
            text: qsTr("Version")
        }
        ComboBox {
            id: version
            Layout.fillWidth: true
            editable: project.isOpen || project.isModified
            enabled: project.isOpen || project.isModified
            model: [qsTr("New version")]

            property bool isNewVersionOrEdit: false


            onCurrentTextChanged: {
                isNewVersionOrEdit = false;
            }

            onEditTextChanged: {
                if(currentText !== editText) {
                    isNewVersionOrEdit = true;
                }
            }

            onDisplayTextChanged: {
                isNewVersionOrEdit = false;
            }

            Connections {
                target: project
                onLoaded:{
                    version.model = Project.getVersionList();
                }

                onProjectNameChanged: {
                    if(project.projectName === "") {
                        version.model = [qsTr("New version")];
                    }
                }
            }

            onCurrentIndexChanged: {
                project.currentProjectVersion  = currentIndex;
            }

        }
    }


    Row {
        id: button
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16

        width:parent.width
        spacing: 16        
        enabled: project.isOpen || project.isModified

        Button {
            icon.name: qsTr("Rename")
            icon.source: "../image/check-solid.svg"
            icon.height: 16
            icon.width: 12
            enabled: version.isNewVersionOrEdit
            onClicked: {
                var i = version.currentIndex;
                Project.setVersionName(version.editText, version.currentIndex);
                version.model = undefined;
                version.model = Project.getVersionList();
                version.currentIndex = i;
                project.save();
                version.isNewVersionOrEdit = false;
            }
        }


        Button {
            icon.name: qsTr("New")
            icon.source: "../image/plus-solid.svg"
            icon.height: 16
            icon.width: 12
            enabled: !version.isNewVersionOrEdit
            onClicked: {                
                Project.addVersion(qsTr("New version"));
                version.model = undefined;
                version.model = Project.getVersionList();
                version.currentIndex = version.count-1;
                version.isNewVersionOrEdit = true;
            }
        }

        Button {
            icon.name:qsTr("Delete")
            icon.source: "../image/trash-solid.svg"
            icon.height: 16
            icon.width: 12
            enabled: version.count > 1 && !version.isNewVersionOrEdit
            onClicked: {
                var i = version.currentIndex;
                Project.subVersion(version.currentIndex);
                version.model = undefined;
                version.model = Project.getVersionList();
                version.currentIndex = i-1;
            }
        }
    }

    Rectangle {
        color:Material.accent
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
    }
}
