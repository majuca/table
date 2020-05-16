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
            text: qsTr("&New project...") + " " + newShortcut.nativeText
            Shortcut{
                id:newShortcut
                sequence: StandardKey.New
                onActivated: {
                    newProject()
                }
            }
            onTriggered: newProject();
        }
        MenuItem {
            text: qsTr("&Open project...") + " " + openShortcut.nativeText
            Shortcut{
                id:openShortcut
                sequence: StandardKey.Open
                onActivated: {
                    openProject()
                }
            }
            onTriggered: openProject();
        }
        MenuItem {
            id: closeItem
            text: qsTr("Close project") + " " + closeSortcut.nativeText

            Shortcut{
                id: closeSortcut
                sequence: StandardKey.Close
                onActivated: {
                    closeProject()
                }
            }
            onTriggered: closeProject()
        }

        MenuSeparator {}

        MenuItem {
            id:saveItem
            text: qsTr("&Save") + " " + saveShortcut.nativeText
            Shortcut {
                id:saveShortcut
                sequence: StandardKey.Save
                onActivated: {
                    save()
                }
            }
            onTriggered: save();
        }
        MenuItem {
            id:saveAsItem
            text: qsTr("Save &as...") + " " + saveAsShortcut.nativeText
            Shortcut {
                id:saveAsShortcut
                sequence: StandardKey.SaveAs
                onActivated: {
                    saveAs()
                }

            }
            onTriggered: saveAs();
        }

        MenuSeparator {}

        MenuItem {
            text: qsTr("Quit") + " " + quitShortcut.nativeText
            onTriggered: Qt.quit()
            Shortcut {
                id:quitShortcut
                sequence: StandardKey.Quit
                onActivated: {
                    Qt.quit()
                }

            }
        }
    }
}
