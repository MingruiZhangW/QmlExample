import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import mock.model 1.0

ListView {
    id: root

    clip: true
    maximumFlickVelocity: 1024

    model: ConversationModel {
        id: conversationModel
    }

    delegate: ItemDelegate {
        id: delegate

        height: 72
        width: root.width

        Text {
            id: conversationUserID

            anchors.left: delegate.left
            anchors.leftMargin: 20
            anchors.verticalCenter: delegate.verticalCenter

            text: ID
            font.pointSize: 10
            color: "yellow"
        }

        Text {
            id: conversationUserName

            anchors.left: conversationUserID.right
            anchors.leftMargin: 10
            anchors.verticalCenter: delegate.verticalCenter

            text: Username
            font.pointSize: 10
            color: "yellow"
        }
    }

    ScrollIndicator.vertical: ScrollIndicator {}
}
