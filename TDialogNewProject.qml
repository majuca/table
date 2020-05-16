import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Dialog {
    width: 400
    title: qsTr("New project")
    standardButtons: Dialog.Ok | Dialog.Cancel

    property alias name: name.text
    property alias type: type.currentIndex

    function openDlg() {
        name.text = "";
        type.currentIndex = 0;
        open();
    }


    GridLayout {
        columns: 2
        anchors.fill: parent

        rowSpacing: 10
        columnSpacing: 10

        Label {
            text: qsTr("Name")
        }
        TextField {
            id: name
            Layout.fillWidth: true
        }

        Label {
            text: qsTr("Type")
        }
        ComboBox {
            id: type
            Layout.fillWidth: true
            model: [ qsTr("Serie"), qsTr("Book") ]
        }
    }
}
