import QtQuick 2.0
import Qt.labs.platform 1.1

import "../javascript/jsproject.js" as Project

Item {
    id:root

    anchors.fill:parent

    /* does project opened */
    property bool isOpen: projectFile != ""
    property bool isModified: false

    property string projectName: ""
    property int projectType: 0
    property string projectFile: ""
    property int currentProjectVersion: 0


    property bool _isClosing: false
    property bool _isNew: false
    property bool _isOpening: false

    signal loaded();

    Component.onCompleted: {
        Project.project = this;
    }

    onCurrentProjectVersionChanged: {
        Project.load();
    }

    /**
    * Create a new project
    */
    function newProject() {
        if(isModified) {
            _isNew = true;
            saveProjectFileDialog.open();
        } else {
            dlgNewProject.openDlg();
        }
    }


    /**
    * Open a project
    */
    function open() {
        if(isModified) {
            _isOpening= true;
            saveProjectFileDialog.open();
        } else {
            openProjectFileDialog.open();
        }
    }

    /**
    * Close the current project
    */
    function close() {
        if(isModified) {
            _isClosing = true;
            saveProjectFileDialog.open();
        } else {
            resetProject();
        }
    }

    /**
    * Save the current project
    */
    function save() {
        if(!isOpen) {
            saveProjectFileDialog.open();
        } else {
            if(Project.save(this) === 0){
                isModified = false;
            }
        }
    }

    /**
    * Save the current project as
    */
    function saveAs() {
        saveProjectFileDialog.open();
    }

    /**
    * Prepare the date for a new project
    */
    function prepareNewProject(name, type) {
        resetProject();

        isModified = true;
        projectName +=  name;
        projectType = type;

    }

    /**
    * Reset parameters of teh current project
    */
    function resetProject() {
        projectName = "";
        projectType = 0;
        projectFile = "";
        currentProjectVersion = 0;
        isModified = false;
        _isClosing = false;
        _isNew = false;
    }



    TDialogNewProject {
        id:dlgNewProject
        anchors.centerIn: parent
        onAccepted: {
            prepareNewProject( dlgNewProject.name,dlgNewProject.type);
        }
    }


    FileDialog {
        id: openProjectFileDialog
        title: qsTr("Please choose a file")
        folder: StandardPaths.writableLocation(StandardPaths.HomeLocation)
        fileMode:FileDialog.OpenFiles
        nameFilters: [ qsTr("Table files") +  " (*.tbl)", qsTr("All files") + " (*)"]
        onAccepted: {            
            if(Project.open(openProjectFileDialog.file)) {
                projectFile = openProjectFileDialog.file;
                projectName = Project.getName();
                projectType = Project.getType();
            } else {
                errorDlg.open();
            }
        }
    }   


    FileDialog {
        id: saveProjectFileDialog
        title: qsTr("Save the Table project")
        folder:StandardPaths.writableLocation(StandardPaths.HomeLocation)
        fileMode:FileDialog.SaveFile
        defaultSuffix: "tbl"
        onAccepted: {
            projectFile = saveProjectFileDialog.file;
            if(Project.save(root) === 0) {
                 isModified = false;
            }

            if(_isClosing) {
                resetProject();
            }

            if(_isNew) {
                dlgNewProject.openDlg();
            }

            if(_isOpening) {
                resetProject();
                openProjectFileDialog.open();
            }
        }
        onRejected: {
            if(_isClosing)  {
                resetProject();
            }

            if(_isNew) {
                dlgNewProject.openDlg();
            }

            if(_isOpening) {
                resetProject();
                openProjectFileDialog.open();
            }
        }
    }
}
