import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Dialog {
    anchors.centerIn: parent
    width: errorMsg.implicitWidth + 32
    title: qsTr("Error")

    Text {
        id: errorMsg
        color:"#FFFFFF"
        anchors.centerIn: parent
        text: qsTr("This is not a valid Table project")
    }

}
