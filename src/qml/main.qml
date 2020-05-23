import QtQuick 2.14
import QtQuick.Controls 2.14
import Qt.labs.settings 1.0

ApplicationWindow {
    id: window
    visible: true
    title: qsTr("Table") + " " + version + (project.projectName !== "" ? " - " + (project.isModified ? project.projectName + "*" : project.projectName) : "")
    visibility:"Maximized"

    menuBar: TMenu {
        id:menu

        closeItem.enabled: project.isOpen || project.isModified
        saveItem.enabled: project.isModified
        saveAsItem.enabled: project.isOpen || project.isModified

        onNewProject: {
            project.newProject();
        }

        onCloseProject: {
            project.close();
        }

        onSave: {
            project.save();
        }

        onSaveAs: {
            project.saveAs();
        }

        onOpenProject: {
            project.open();
        }

    }



    TProject {
        id: project
    }


    TSplitView {
        id:split
        project: project
    }


    TAboutDialog {
        id:aboutDialog
    }

    TQtDialog {
        id:qtDialog
    }

    Settings {
        id: settings
    }
}
