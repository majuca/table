import QtQuick 2.0
import QtQuick.Controls 2.14
import "../javascript/jsproject.js" as Project

Flickable {
    id: flickable
    anchors.fill : parent
    clip: true
    contentHeight: height
    contentWidth: width

    Component.onCompleted: {
        Project.flickable = flickable
    }

    ScrollBar.horizontal: ScrollBar {}
    ScrollBar.vertical: ScrollBar {}

    property bool selected: false

    function setSelected() {
        selected = false;
        for(var i=0; i<Project.flickableImage.length; i++) {
            if(Project.flickableImage[i].obj) {
                if(Project.flickableImage[i].obj.selected) {
                    selected = true;
                }
            }
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
        contentWidth = biggerX

    }

    function add(image) {
        var component = Qt.createComponent("TTableImage.qml");

        var obj = component.createObject(flickable.contentItem,{
                                   "source":image.source,
                                   "height":200,
                                   "isDragable":true,
                                   "x":image.x,
                                   "y":image.y,
                                   "height":image.height
                                         });
        Project.flickableImage.push({"obj":obj,"cmp":component});
        resize(obj);

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
            flickable.reset();
        }
    }


}
