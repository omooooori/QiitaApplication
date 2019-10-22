import QtQuick 2.9
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Button {
    id: control
    width: 270
    height:  100

    text: qsTr("Button")

    property color buttonColor: "lightblue"

    style: ButtonStyle {
        background: Rectangle {
            border.width: control.activeFocus ? 2 : 1
            border.color: "#888"
            radius: 4
            gradient: Gradient {
                GradientStop { position: 0 ; color: control.pressed ? Qt.darker(buttonColor, 1.5) : buttonColor }
                GradientStop { position: 1 ; color: control.pressed ? Qt.darker(buttonColor, 3.0) : Qt.darker(buttonColor, 1.0) }
            }
        }
        label: Text {
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Helvetica"
            font.pointSize: 20
            color: "blue"
            text: control.text
        }
    }

}
