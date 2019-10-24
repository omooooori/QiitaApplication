import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: root

    header: MyHeader {
        id: header
        toolButtonIcon: "qrc:/images/headline-24px.svg"
        onToolButtonClicked: drawer.open()
    }

    Drawer {
        id: drawer

        width: Math.min(root.width, root.height) / 3
        height: root.height

        ListView {
            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.text
                highlighted: ListView.isCurrentItem
                onClicked: {
                    drawer.close()
                    model.triggered()
                }
            }

            model: ListModel {
                ListElement {
                    text: qsTr("Open...")
                }
                ListElement {
                    text: qsTr("About...")
                }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Image {
            width: 400
            height: 400
            Layout.alignment: Qt.AlignHCenter
            fillMode: Image.PreserveAspectFit
            clip: true
            source: "qrc:/images/DotPicture.png"
        }

        Repeater {
            model: ScreenTransitionModel {}
            Component.onCompleted: console.log("inside Repeater delegate. model = ", model)

            delegate: MyButton {
                text: model.label
                Layout.alignment: Qt.AlignHCenter
                onClicked: model.label === "End" ? SplashShow.end() : root.StackView.view.push(model.path)
                Component.onCompleted: console.log("MyButton width = ", width + ", MyButton height = ",  height)
            }
        }

        ImageButton {
            id: rockButton
            source: "qrc:/images/Lock.svg"
            maskSource: "qrc:/images/RoundMask.svg"
        }

    }
}
