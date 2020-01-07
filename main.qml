import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Window {
    id: mainWindow

    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    SplitView {
        id: splitView

        anchors.fill: parent;
        width: mainWindow.width
        height: mainWindow.height
        resizing: false

        Rectangle {
            id: callViewRect

            anchors.left: parent.left
            width: splitView.width / 2
            height: splitView.height

            ComboBox {
                id: accountComboBox

                anchors.top: callViewRect.top
                width: callViewRect.width
                height: 50
                model: animalModel
                currentIndex: 0

                Image {
                    id: userImageRoot

                    anchors.left: accountComboBox.left
                    anchors.verticalCenter: accountComboBox.verticalCenter
                    width: 30
                    height: accountComboBox.height
                    fillMode: Image.PreserveAspectFit
                    source: "images/jami.png"
                }

                Text {
                    anchors.left: userImageRoot.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: animalModel.data(animalModel.index(0,0), 257) + " " + animalModel.data(animalModel.index(0,0), 258)
                }

                background: Rectangle {
                    implicitWidth: accountComboBox.width
                    implicitHeight: accountComboBox.height
                    border.color: accountComboBox.pressed ? "#17a81a" : "#21be2b"
                    border.width: accountComboBox.visualFocus ? 2 : 1
                    radius: 2
                }

                indicator: null

                delegate:ItemDelegate {
                    Image {
                        id: userImage

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                        source: "images/jami.png"
                    }
                    Text {
                        anchors.left: userImage.right
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Animal: " + type + ", " + size
                    }
                }
            }
        }

        Rectangle {
            id: welcomeRect

            anchors.left: callViewRect.right
            width: splitView.width / 2
            height: splitView.height

            Label {
                anchors.centerIn: welcomeRect
                width: 200
                height: 200
                text: "Welcome"
                font.pixelSize: 22
                font.italic: true
            }
        }
    }

    onWidthChanged: {
        if(mainWindow.width < 500){
            welcomeRect.visible = false
            callViewRect.width = mainWindow.width
        }
    }
}
