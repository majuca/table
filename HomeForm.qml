import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import Qt.labs.platform 1.1
import QtQml 2.14

Page {
    title: window.currentProjectName !== "" ? window.currentProjectName : qsTr("Home")

    function addImage(id,url,params) {
        id = id === 0 ? Math.floor(Math.random() * Math.floor(Math.random() * Date.now())) : id;
        if(!window.images[id]) {
            window.images[id] = {"url":url, "cmp": Qt.createComponent("MyImage.qml"), "obj":null, "uniqId":id, "params":params};
        } else {
           console.debug("Id existing");
        }

        if (window.images[id].cmp.status === Component.Ready) {
            console.debug("FINISHED");
            finishCreation();
        } else {
            console.debug("WAIT FINISHED");
            window.images[id].cmp.statusChanged.connect(finishCreation());
        }
    }

    function finishCreation() {
        for(var id in window.images) {
            if (window.images[id].cmp.status === Component.Ready && !window.images[id].obj) {
                window.images[id].obj = window.images[id].cmp.createObject(flickable.contentItem, {"uniqId":window.images[id].uniqId, "source":window.images[id].url});
                imageNumber++;
                if (window.images[id].obj === null) {
                    // Error Handling
                    console.log("Error creating object");
                } else {
                    window.images[id].obj.deleteImage.connect(deleteImage);
                    if(window.images[id].params) {
                        window.images[id].obj.loadImageParameters(window.images[id].params);
                        //flickable.resize(window.images[id].obj);
                    }
                }
            } else if (window.images[id].cmp.status === Component.Error) {
                // Error Handling
                console.log("Error loading component:", window.images[id].cmp.errorString());
            }
        }
    }

    function deleteImage(uniqId) {
        console.debug(uniqId);

        for(var id in window.images) {
            if(uniqId === id) {
                window.images[id].obj.destroy();
                delete window.images[id];
                imageNumber--;
            }
        }
    }

    function saveProject(fileUrl) {
        var request = new XMLHttpRequest();
        var text = {"name":window.currentProjectName, "version":[{"name":"Version 1","images":[]}]}

        for(var id in window.images) {
            var jsonImg = window.images[id].obj.getJsonDataProject();
            text.version[window.currentIndexVersion].images.push(jsonImg);
        }

        request.open("PUT", fileUrl, false);
        request.send(JSON.stringify(text));
        return request.status;
    }

    function openProject(fileUrl) {
        var request = new XMLHttpRequest();
        request.open("GET", fileUrl, false);
        request.send(null);
        console.debug(fileUrl, request.responseText)
        var json =JSON.parse(request.responseText);

        for(var id in window.images) {
            window.images[id].obj.destroy();
        }

        imageNumber = 0;

        window.images = [];

        if("name" in json) {
            window.currentProjectName = json.name;
            if("version" in json) {
                var currentVersion = json.version[window.currentIndexVersion];
                for(var i=0; i<currentVersion.images.length; i++) {
                    addImage(currentVersion.images[i].uniqId, currentVersion.images[i].source, currentVersion.images[i]);
                }
            }
        }
    }



    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)
        fileMode:FileDialog.OpenFiles
        nameFilters: [ qsTr("Image files (*.jpg *.jpeg *.png *.tiff)"), qsTr("All files (*)") ]
        onAccepted: {
            for(var i=0; i<fileDialog.currentFiles.length; i++) {
                addImage(0, fileDialog.currentFiles[i], null);
            }
        }
    }

    FileDialog {
        id: openProjectFileDialog
        title: "Please choose a file"
        folder: StandardPaths.writableLocation(StandardPaths.HomeLocation)
        fileMode:FileDialog.OpenFiles
        nameFilters: [ qsTr("Image files (*.tbl)"), qsTr("All files (*)") ]
        onAccepted: {
            window.currentProjectFile = openProjectFileDialog.file;
            openProject(openProjectFileDialog.file);
        }
    }

    FileDialog {
        id: savePropjectFileDialog
        title: qsTr("Save the Tabel project")
        folder:StandardPaths.writableLocation(StandardPaths.HomeLocation)
        fileMode:FileDialog.SaveFile
        defaultSuffix: "tbl"
        onAccepted: {
            saveProject(savePropjectFileDialog.file);
        }
    }

    Connections {
        target: window
        function onSave() {
            if(window.currentProjectFile === "") {
                savePropjectFileDialog.open();
            } else {
                saveProject(window.currentProjectFile);
            }
        }

        function onSaveAs() {
            savePropjectFileDialog.open();
        }

        function onOpenProject() {
            openProjectFileDialog.open();
        }

        function onReGrid() {

            var x = 50;
            var y = 250;
            var margin = 16;
            var heightAdd = 0;
            var i=0;
            for(var id in window.images) {
                if(!window.images[id].obj.lock) {
                    console.debug(i++);
                    window.images[id].obj.x = x;
                    window.images[id].obj.y = y;
                    x += window.images[id].obj.width + margin;
                    if(heightAdd<window.images[id].obj.height ) {
                        heightAdd = window.images[id].obj.height;
                    }

                    if(x>window.width) {
                       y += heightAdd + margin;
                       x = 50;
                    }
                }
            }
        }

        function onUnLockAll() {
            for(var id in window.images) {
                window.images[id].obj.lock = false;
            }
        }

        function onLockAll() {
            for(var id in window.images) {
                window.images[id].obj.lock = true;
            }
        }
    }

    Flickable {
        id: flickable
        anchors.fill:parent
        clip:true
        contentWidth: 0
        contentHeight: 0
        boundsBehavior:
            Flickable.StopAtBounds
        function resize(img) {
            if(contentWidth<img.x+img.width) {
                contentWidth = img.x+img.width + 100;
            }
            if(contentHeight<img.y+img.height) {
                contentHeight = img.y+img.height + 100;
            }
        }

        ScrollBar.vertical: ScrollBar { }
        ScrollBar.horizontal: ScrollBar { }
    }


    RoundButton {
        id:add
        width: 64
        height: 64
        visible: window.currentProjectName !== ""
        anchors.bottom:parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 32
        anchors.rightMargin: 32
        icon.source: "./image/plus-solid.svg"
        onClicked: {
            fileDialog.visible = true;
        }
        background: Rectangle {
            radius: width
            color: Material.accent
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
