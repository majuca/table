import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Dialog {
    anchors.centerIn: parent
    width: 500
    height: 300
    TabBar {
        id:bar
        width: parent.width
        TabButton {
            text: qsTr("About")
        }
        TabButton {
            text: qsTr("Author")
        }
        TabButton {
            text: qsTr("Licence")
        }
    }

    StackLayout {
         width: parent.width
         height:parent.height
         currentIndex: bar.currentIndex
         anchors.top:parent.top
         anchors.topMargin: bar.implicitHeight + 16
         Item {
             Column {
                 anchors.horizontalCenter: parent.horizontalCenter
                 anchors.top:parent.top
                 anchors.topMargin: 32
                 spacing: 8
                 Image {
                     id: logo
                     source: "../image/64x64/table.png"
                     anchors.horizontalCenter: parent.horizontalCenter
                 }
                 Text {
                     text: "Table" + " " + version
                     color: "#FFFFFF"
                     font.bold:true
                     anchors.horizontalCenter: parent.horizontalCenter
                 }
                 Text {
                     text: "copyright (c) " + new Date().getFullYear()
                     color: "#FFFFFF"
                     anchors.horizontalCenter: parent.horizontalCenter
                 }
             }
         }

         Item {


             Column {
                 spacing: 8
                 Text {
                     text: qsTr("Developpement team")
                     color: "#FFFFFF"
                     font.bold:true
                 }

                 Text {
                     text: "Jean-Luc Gyger\t\tjean-luc@jeanlucgyger.ch"
                     color: "#FFFFFF"
                 }
             }
         }

         Item {
             Column {
                 spacing: 8
                 Text {
                     text: "GNU GENERAL PUBLIC LICENSE<br/>Version 3, 29 June 2007"
                     color: "#FFFFFF"
                     font.bold:true
                 }

                 Text {
                     text: "<a style='color:#ffffff' href='https://www.gnu.org/licenses/gpl-3.0.html'>https://www.gnu.org/licenses/gpl-3.0.html</a>"
                     color: "#FFFFFF"
                     textFormat:Text.RichText
                     onLinkActivated: Qt.openUrlExternally(link)
                 }
             }
         }
    }

}
