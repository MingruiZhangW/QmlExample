import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: rootWindow

    width: 500
    height: 500

    visible: true

    title: qsTr("Model Mock")

    Rectangle {
        id: root

        anchors.fill: parent

        color: "lightblue"

        ConversationListView {
            id: conversationListView

            anchors.left: root.left

            width: rootWindow.width / 2
            height: rootWindow.height
        }

        Rectangle {
            id: controlRect

            anchors.right: root.right

            width: rootWindow.width / 2
            height: rootWindow.height

            color: "lightpink"

            ColumnLayout {
                anchors.centerIn: controlRect

                spacing: 10

                Button {
                    text: "Add On Top"
                    onClicked: conversationListView.model.insertConversationOnTop()
                }

                Button {
                    text: "Add On Bottom"
                    onClicked: conversationListView.model.insertConversationOnBottom()
                }

                Button {
                    text: "Add On Middle"
                    onClicked: conversationListView.model.insertConversationOnMiddle()
                }

                Button {
                    text: "Remove On Top"
                    onClicked: conversationListView.model.removeConversationOnTop()
                }

                Button {
                    text: "Remove On Bottom"
                    onClicked: conversationListView.model.removeConversationOnBottom()
                }

                Button {
                    text: "Remove On Middle"
                    onClicked: conversationListView.model.removeConversationOnMiddle()
                }

                Button {
                    text: "Move Bottom to Top"
                    onClicked: conversationListView.model.moveBottomToTop()
                }
            }
        }
    }
}
