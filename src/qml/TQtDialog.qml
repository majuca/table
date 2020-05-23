import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Dialog {
    anchors.centerIn: parent
    width: 600
    height: 600

    Text {
        width:parent.width - 16
        color:"#FFFFFF"
        wrapMode: Text.WordWrap
        anchors.centerIn: parent
        textFormat:Text.RichText
        text: "<h3>About Qt</h3>" +
        "<p>This program uses Qt version " + qtVersion + ".</p>" +
        "<p>Qt is a C++ toolkit for cross-platform application development.</p>" +
        "<p>Qt provides single-source portability across all major desktop " +
        "operating systems. It is also available for embedded Linux and other " +
        "embedded and mobile operating systems.</p>" +
        "<p>Qt is available under three different licensing options designed " +
        "to accommodate the needs of our various users.</p>" +
        "<p>Qt licensed under our commercial license agreement is appropriate " +
        "for development of proprietary/commercial software where you do not " +
        "want to share any source code with third parties or otherwise cannot " +
        "comply with the terms of the GNU LGPL version 3 or GNU LGPL version 2.1.</p>" +
        "<p>Qt licensed under the GNU LGPL version 3 is appropriate for the " +
        "development of Qt&nbsp;applications provided you can comply with the terms " +
        "and conditions of the GNU LGPL version 3.</p>" +
        "<p>Qt licensed under the GNU LGPL version 2.1 is appropriate for the " +
        "development of Qt&nbsp;applications provided you can comply with the terms " +
        "and conditions of the GNU LGPL version 2.1.</p>" +
        "<p>Please see <a style='color:#ffffff' href=\"http://qt.io/licensing/\">qt.io/licensing</a> " +
        "for an overview of Qt licensing.</p>" +
        "<p>Copyright (C) " + new Date().getFullYear() +" The Qt Company Ltd and other " +
        "contributors.</p>" +
        "<p>Qt and the Qt logo are trademarks of The Qt Company Ltd.</p>" +
        "<p>Qt is The Qt Company Ltd product developed as an open source " +
        "project. See <a style='color:#ffffff' href=\"http://qt.io/\"> qt.io</a> for more information.</p>"
        onLinkActivated: Qt.openUrlExternally(link)
    }
}
