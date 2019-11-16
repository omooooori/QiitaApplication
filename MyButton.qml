import QtQuick 2.9
import QtQuick.Controls 2.3

Rectangle {

    property alias icon: image.source
    property alias label: text.text
    implicitWidth: text.implicitWidth + image.implicitWidth + 10
    implicitHeight: Math.max(text.implicitHeight, image.implicitHeight)

    border.color : "black"
    border.width: 1
    radius: 2

    signal buttonClick()

    Row {

        Image {
            id: image
            sourceSize.width: 50
            sourceSize.height: 50
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: text
            wrapMode: Text.Wrap
            font.pointSize: 25
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: parent.buttonClick()
        hoverEnabled: true

        onEntered:{
            parent.border.width= 2
        }

        onCanceled:{
            parent.border.width= 1
        }

        onExited: {
            parent.border.width= 1
        }
    }
}
