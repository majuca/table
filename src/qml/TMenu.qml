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
        title: qsTr("&File")

        width: 380

        Shortcut{
            id:fileShortcut
            sequence:"Ctrl+f"
            onActivated: {
                fileMenu.open();
            }
        }

        MenuItem {
            text: qsTr("&New project...") + "\t\t" + newShortcut.nativeText
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
            text: qsTr("&Open project...") + "\t\t" + openShortcut.nativeText
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
            text: qsTr("Close project") + "\t\t" + closeSortcut.nativeText

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
            text: qsTr("&Save") + "\t\t\t" + saveShortcut.nativeText
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
            text: qsTr("Save &as...") + "\t\t" + saveAsShortcut.nativeText
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
            text: qsTr("Setting...")
            onTriggered: {

            }

        }

        MenuSeparator {}

        MenuItem {
            text: qsTr("Quit") + "\t\t\t" + quitShortcut.nativeText
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

    Menu {
        id: helpMenu
        title: qsTr("Help")

        MenuItem {
            text: qsTr("About Table")
            onTriggered: {
                aboutDialog.open()
            }

        }
        MenuItem {
            text: qsTr("About Qt")
            onTriggered: {
                qtDialog.open()
            }

        }
    }
}
