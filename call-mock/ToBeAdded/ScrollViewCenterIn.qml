import QtQuick 2.14
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.14
import net.jami.Models 1.0
import net.jami.Adapters 1.0

import "../../constant"
import "../../commoncomponents"

BaseDialog {
    id: root

    height: aboutPopUpContentRectColumnLayout.implicitHeight

    title: qsTr("About")

    ProjectCreditsScrollView {
        id: projectCreditsScrollView

        visible: false
    }

    ChangeLogScrollView {
        id: changeLogScrollView

        visible: false
    }

    contentItem: Rectangle {
        id: contentRect

        implicitWidth: 400

        ScrollView {
            id: aboutPopUpScrollView

            anchors.fill: parent

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AsNeeded

            clip: true

            ColumnLayout {
                width: Math.max(root.width, implicitWidth)
                height: Math.max(aboutPopUpScrollView.height, implicitHeight)

                spacing: 0

                ColumnLayout {
                    id: aboutPopUpContentRectColumnLayout

                    Layout.alignment: Qt.AlignCenter

                    Image {
                        id: aboutPopUPJamiLogoImage

                        Layout.alignment: Qt.AlignCenter
                        Layout.topMargin: JamiTheme.preferredMarginSize
                        Layout.preferredWidth: contentRect.width
                        Layout.preferredHeight: 100

                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/images/logo-jami-standard-coul.png"
                        mipmap: true
                    }

                    Label {
                        id: jamiVersionText

                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredWidth: contentRect.width
                        Layout.preferredHeight: textMetricsjamiVersionText.boundingRect.height

                        font.pointSize: JamiTheme.textFontSize

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        text: textMetricsjamiVersionText.text

                        TextMetrics {
                            id: textMetricsjamiVersionText
                            font: jamiVersionText.font
                            text: JamiStrings.version + ": " + UtilsAdapter.getVersionStr()
                        }
                    }

                    Label {
                        id: jamiSlogansText

                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredWidth: contentRect.width
                        Layout.preferredHeight: textMetricsjamiSlogansText.boundingRect.height
                        Layout.topMargin: 5

                        wrapMode: Text.WordWrap
                        font.pointSize: JamiTheme.textFontSize

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        text: textMetricsjamiSlogansText.text

                        TextMetrics {
                            id: textMetricsjamiSlogansText
                            font: jamiSlogansText.font
                            text: JamiStrings.slogan
                        }
                    }

                    Label {
                        id: jamiDeclarationText

                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredWidth: contentRect.width
                        Layout.preferredHeight: 40
                        Layout.topMargin: 5

                        wrapMode: Text.WordWrap
                        font.pointSize: JamiTheme.textFontSize

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter


                        // TextMetrics does not work for multi-line.
                        text: JamiStrings.declaration
                    }

                    Label {
                        id: jamiDeclarationHyperText

                        Layout.alignment: Qt.AlignCenter

                        // Strangely, hoveredLink works badly when width grows too large
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: textMetricsjamiDeclarationHyperText.boundingRect.height
                        Layout.topMargin: 5
                        Layout.bottomMargin: 5

                        font.pointSize: JamiTheme.textFontSize
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        text: textMetricsjamiDeclarationHyperText.text
                        onLinkActivated: Qt.openUrlExternally(link)

                        TextMetrics {
                            id: textMetricsjamiDeclarationHyperText
                            font: jamiDeclarationHyperText.font
                            text: '<html><style type="text/css"></style><a href="https://jami.net">jami.net</a></html>'
                        }

                        MouseArea {
                            anchors.fill: parent

                            // We don't want to eat clicks on the Text.
                            acceptedButtons: Qt.NoButton
                            cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }
                    }

                    Label {
                        id: jamiDeclarationYearText

                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredWidth: contentRect.width
                        Layout.preferredHeight: textMetricsjamiDeclarationYearText.boundingRect.height
                        Layout.bottomMargin: 5

                        font.pointSize: JamiTheme.textFontSize

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        text: textMetricsjamiDeclarationYearText.text

                        TextMetrics {
                            id: textMetricsjamiDeclarationYearText
                            font: jamiDeclarationYearText.font
                            text: JamiStrings.companyDeclarationYear
                        }
                    }

                    Label {
                        id: jamiNoneWarrantyHyperText

                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredWidth: 300
                        Layout.preferredHeight: textMetricsjamiNoneWarrantyHyperText.boundingRect.height * 2
                        Layout.bottomMargin: 10

                        wrapMode: Text.WordWrap
                        font.pointSize: JamiTheme.tinyFontSize

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        text: textMetricsjamiNoneWarrantyHyperText.text
                        onLinkActivated: Qt.openUrlExternally(link)

                        TextMetrics {
                            id: textMetricsjamiNoneWarrantyHyperText
                            font: jamiDeclarationHyperText.font
                            text: '<html><style type="text/css"></style>This program comes with absolutely no warranty.<br\>See the <a href="http://www.gnu.org/licenses/gpl-3.0.html">GNU General Public License, version 3 or later</a> for details.</html>'
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.NoButton
                            cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }
                    }

                    Rectangle {
                        id: buttonGroupChangeLogAndCredits

                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredWidth: contentRect.width
                        Layout.preferredHeight: 32

                        RowLayout {
                            id: buttonGroupChangeLogAndCreditsRowLayout

                            anchors.fill: parent

                            MaterialButton {
                                id: changeLogButton
                                text: JamiStrings.changelog
                                color: projectCreditsScrollView.visible? JamiTheme.buttonTintedGreyInactive :
                                                                         JamiTheme.buttonTintedGrey
                                hoveredColor: JamiTheme.buttonTintedGreyHovered
                                pressedColor: JamiTheme.buttonTintedGreyPressed

                                Layout.alignment: Qt.AlignHCenter
                                Layout.preferredWidth: JamiTheme.preferredFieldWidth / 2
                                Layout.preferredHeight: JamiTheme.preferredFieldHeight

                                onClicked: {
                                    if (changeLogOrCreditsStack.depth > 1) {
                                        changeLogOrCreditsStack.pop()
                                    }
                                }
                            }

                            MaterialButton {
                                id: creditsButton
                                text: JamiStrings.credits
                                color: projectCreditsScrollView.visible? JamiTheme.buttonTintedGrey :
                                                                         JamiTheme.buttonTintedGreyInactive
                                hoveredColor: JamiTheme.buttonTintedGreyHovered
                                pressedColor: JamiTheme.buttonTintedGreyPressed
                                Layout.alignment: Qt.AlignHCenter
                                Layout.preferredWidth: JamiTheme.preferredFieldWidth / 2
                                Layout.preferredHeight: JamiTheme.preferredFieldHeight

                                onClicked: {
                                    if (changeLogOrCreditsStack.depth == 1) {
                                        changeLogOrCreditsStack.push(
                                                    projectCreditsScrollView)
                                    }
                                }
                            }
                        }
                    }

                    StackView {
                        id: changeLogOrCreditsStack

                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredWidth: contentRect.width - JamiTheme.preferredMarginSize * 2
                        Layout.preferredHeight: 150
                        Layout.margins: JamiTheme.preferredMarginSize

                        initialItem: changeLogScrollView

                        clip: true
                    }

                    MaterialButton {
                        id: btnClose

                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: JamiTheme.preferredFieldWidth / 2
                        Layout.preferredHeight: JamiTheme.preferredFieldHeight
                        Layout.bottomMargin: JamiTheme.preferredMarginSize

                        text: qsTr("Close")
                        color: enabled? JamiTheme.buttonTintedBlack : JamiTheme.buttonTintedGrey
                        hoveredColor: JamiTheme.buttonTintedBlackHovered
                        pressedColor: JamiTheme.buttonTintedBlackPressed
                        outlined: true

                        onClicked: {
                            close()
                        }
                    }
                }
            }
        }
    }
}
