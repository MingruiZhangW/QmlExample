import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Window {
    id: mainWindow

    property int minWidth: 300
    property int minHeight: 400
    property int textFontSize: 8

    visible: true
    width: 580
    minimumWidth: minWidth
    minimumHeight: minHeight
    title: qsTr("Hello World")

    Rectangle {
        id: splitView

        anchors.fill: parent;
        width: mainWindow.width
        height: mainWindow.height

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
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: animalModel.data(animalModel.index(0,0), 257) + " " + animalModel.data(animalModel.index(0,0), 258)
                }

                background: Rectangle {
                    id: rootItemBackground

                    implicitWidth: accountComboBox.width
                    implicitHeight: accountComboBox.height
                    border.color: accountComboBox.pressed ? "#17a81a" : "#21be2b"
                    border.width: accountComboBox.visualFocus ? 2 : 1
                    radius: 2
                }

                MouseArea {
                    anchors.fill: parent;
                    hoverEnabled: true;
                    onPressed: { rootItemBackground.color = "#c0c0c0"; }
                    onReleased: {
                        rootItemBackground.color = "#e0e0e0"
                        if(accountComboBox.down) {
                            accountComboBox.popup.close()
                        } else {
                            accountComboBox.popup.open()
                        }
                    }
                    onEntered: { rootItemBackground.color = "#c7c7c7"; }
                    onExited: { rootItemBackground.color = Qt.binding(function() { return rootItemBackground.down ? "#e0e0e0" :"#fdfdfd" }); }
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
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Animal: " + type + ", " + size
                    }

                    background: Rectangle {
                        id: itemCoboBackground

                        implicitWidth: accountComboBox.width
                        implicitHeight: accountComboBox.height
                        border.width: 0
                    }

                    MouseArea {
                        anchors.fill: parent;
                        hoverEnabled: true;
                        onPressed: { itemCoboBackground.color = "#c0c0c0"; }
                        onReleased: {
                            itemCoboBackground.color = "#e0e0e0"
                        }
                        onEntered: { itemCoboBackground.color = "#c7c7c7"; }
                        onExited: { itemCoboBackground.color = Qt.binding(function() { return itemCoboBackground.down ? "#e0e0e0" :"#fdfdfd" }); }
                    }
                }
            }

            ListView {
                id: smartListView

                anchors.bottom: parent.bottom
                anchors.left: parent.left
                width: parent.width
                height: parent.height - accountComboBox.height - 30
                model: 20
                clip: true

                delegate: ItemDelegate {
                    text: "Item" + index

                    background: Rectangle {
                        id: itemSmartListBackground

                        implicitWidth: smartListView.width
                        implicitHeight: 50
                        border.width: 0
                    }

                    MouseArea {
                        anchors.fill: parent;
                        hoverEnabled: true;
                        onPressed: { itemSmartListBackground.color = "#c0c0c0"; }
                        onReleased: {
                            itemSmartListBackground.color = "#e0e0e0"
                        }
                        onEntered: { itemSmartListBackground.color = "#c7c7c7"; }
                        onExited: { itemSmartListBackground.color = Qt.binding(function() { return itemSmartListBackground.down ? "#e0e0e0" :"#fdfdfd" }); }
                    }
                }

                ScrollBar.vertical: ScrollBar {
                    id: controlBar

                    parent: smartListView
                    anchors.top: smartListView.top
                    anchors.right: smartListView.right
                    size: 0.5
                    orientation: Qt.Vertical
                    policy: smartListView.contentHeight > smartListView.height ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff

                    contentItem: Rectangle {
                        implicitWidth: 5
                        implicitHeight: 100
                        radius: width / 2
                        color: controlBar.pressed ? "#81e889" : "#c2f4c6"
                    }
                }
            }
        }

        Rectangle {
            id: welcomeRect

            anchors.right: parent.right
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
        } else if(mainWindow.width >= 500) {
            welcomeRect.visible = true
            callViewRect.width = mainWindow.width / 2
        }
    }
}
