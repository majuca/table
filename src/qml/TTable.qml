import QtQuick 2.0
import QtQuick.Controls 2.14
import "../javascript/jsproject.js" as Project

Flickable {
    id: flickable
    anchors.fill : parent
    clip: true
    contentHeight: height
    contentWidth: width
    //transformOrigin: Item.Center

    Component.onCompleted: {
        Project.flickable = flickable
    }

    ScrollBar.horizontal: ScrollBar {}
    ScrollBar.vertical: ScrollBar {}

    property bool selected: false
    property var currentSelectImg: null
    property bool selectMulti: false

    function setSelected(img) {
        for(var i=0; i<Project.flickableImage.length; i++) {
            if(Project.flickableImage[i].obj && Project.flickableImage[i].obj !== img && Project.flickableImage[i].obj.selected) {
                Project.flickableImage[i].obj.selected = false;
            }
        }


        if(img) {
            selected = true;
            currentSelectImg = img
            currentSelectImg.selected = true;
        } else {
            currentSelectImg = null;
            selected = false;
        }
    }

    function resize() {

        var biggerX = 0;
        var biggerY = 0;

        for(var i=0; i<Project.flickableImage.length; i++) {
            var img = Project.flickableImage[i].obj;
            if(img) {
                if(biggerX<img.x+img.width) {
                    biggerX = img.x+img.width + 100;
                }
                if(biggerY<img.y+img.height) {
                    biggerY = img.y+img.height + 100;
                }
            }
        }

        if(biggerY < height) {
            biggerY = height;
        }
        if(biggerX < width) {
            biggerX = width;
        }

        contentHeight = biggerY;
        contentWidth = biggerX;

    }

    function add(image) {
        var component = Qt.createComponent("TTableImage.qml");                             
        if (component.status === Component.Ready) {

            var obj = component.createObject(flickable.contentItem,{
                                       "source":image.source,
                                       "x":image.x,
                                       "y":image.y,
                                       "height":image.height,
                                       "frameType":image.frameType,
                                       "format":image.format,
                                       "size":image.size,
                                       "horizontal":image.horizontal,
                                       "vertical":image.vertical
                                             });

            Project.flickableImage.push({"obj":obj,"cmp":component});
            resize(obj);
        } else {
            console.debug("Component not ready")
        }

    }

    function reset() {
        for(var i=0; i<Project.flickableImage.length;i++) {
            if(Project.flickableImage[i].obj) {
                Project.flickableImage[i].obj.destroy();
            }
        }

        Project.flickableImage = []
    }

    Connections {
        target: project
        onIsOpenChanged: {
            if(!project.isOpen) {
                flickable.reset();
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true

        onClicked: {
            for(var i=0; i<Project.flickableImage.length; i++) {
                if(Project.flickableImage[i].obj) {
                    Project.flickableImage[i].obj.selected = false;
                }
            }

            currentSelectImg = null;
            selected = false;

        }



    }


}
