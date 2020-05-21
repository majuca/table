import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls.Material 2.14

import "../javascript/jsproject.js" as Project


Item {
    width:parent.width-16
    anchors.horizontalCenter: parent.horizontalCenter
    height: glForm.implicitHeight
    GridLayout {
        id:glForm
        columns: 2
        width:parent.width
        rowSpacing: 8
        columnSpacing: 8

        Label {
            text: qsTr("Frame format")
        }
        ComboBox {
            id: version
            Layout.fillWidth: true
            enabled: project.isOpen || project.isModified
            model: [qsTr("No frame"), qsTr("French"), qsTr("Italian")]
        }
    }

}
