import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Dialog {
    anchors.centerIn: parent
    width: 500
    height: 300

    title: qsTr("Preferences")

    GridLayout {
        columns: 2
        anchors.fill: parent

        rowSpacing: 10
        columnSpacing: 10


        Label {
            text: qsTr("Language")
        }
        ComboBox {
            id: type
            Layout.fillWidth: true
            model: tools.getLanguageList();

            Component.onCompleted: {
                var currentLang = Qt.locale().name.substring(0,2);
                var list = tools.getLanguageList();
                for(var i=0; i<list.length; i++) {
                    if(list[i] === currentLang) {
                        currentIndex = i;
                        i=list.lengt;
                    }
                }
            }

            onCurrentTextChanged: {
                console.debug(currentText);
                tools.switchLanguage(currentText);
                settings.currentLanguage = currentText;
            }
        }
    }
}
