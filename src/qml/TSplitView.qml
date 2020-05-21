import QtQuick 2.0
import QtQuick.Controls 2.14

SplitView {
    id: split
    anchors.fill: parent
    orientation: Qt.Horizontal

    property var project: null

    //property var proxyDropArea: dropArea

    Item {
        SplitView.fillWidth: true

        SplitView {
            anchors.fill: parent
            orientation: Qt.Vertical


            Item {
                SplitView.fillHeight: true

                Flickable {
                    id: flickable
                    anchors.fill : parent
                    clip: true

                }

            }

            Item {
                SplitView.minimumHeight : 0
                SplitView.preferredHeight: 250
                SplitView.maximumHeight: 300

                TListImage {

                }
            }
        }
     }

    Item {

        SplitView.minimumWidth: 0
        SplitView.preferredWidth: 300
        SplitView.maximumWidth: 400

        TProjectForm {
            id:projectForm

        }

    }

}
