import QtQuick 2.14
import QtQuick.Controls 2.14

MenuBar {

    property alias closeItem: closeItem
    property alias saveItem: saveItem
    property alias saveAsItem: saveAsItem

    signal save();
    signal saveAs();
    signal openProject();
    signal closeProject();
    signal newProject();

    Menu {
        id: fileMenu
        title: qsTr("File")
        MenuItem {
            text: qsTr("New project...")
            onTriggered: newProject();
        }
        MenuItem {
            text: qsTr("Open project...")
            onTriggered: openProject();
        }
        MenuItem {
            id: closeItem
            text: qsTr("Close project")
            onTriggered: closeProject()
        }

        MenuSeparator {}

        MenuItem {
            id:saveItem
            text: qsTr("Save")
            onTriggered: save();
        }
        MenuItem {
            id:saveAsItem
            text: qsTr("Save as...")
            onTriggered: saveAs();
        }

        MenuSeparator {}

        MenuItem {
            text: qsTr("Quit")
            onTriggered: Qt.quit()
        }
    }
}
