import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Window {
    id: root
    width: 300
    height: 300

    title: "Generated Window"

    Rectangle {
        id: rootRect

        anchors.fill: parent

        Text {
            id: windowsText

            anchors.centerIn: rootRect
            width: 50
            height: 50

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 10
            text: qsTr("Hello World")
        }

        Button {
            id: okButton

            anchors.bottom: rootRect.bottom
            anchors.bottomMargin: 30
            anchors.left: rootRect.left
            anchors.leftMargin: rootRect.width / 2 - okButton.width / 2

            width: 50
            height: 50
            text: "Ok"

            onClicked: {
                root.close()
            }
        }
    }
}
