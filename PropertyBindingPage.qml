import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.2

Page {
    id: root

    header: MyHeader{
        toolButtonIcon: "qrc:/images/arrow_back-24px.svg"
        onToolButtonClicked: root.StackView.view.pop()
    }

    Button {
        id: button
        width: root.width / 2
        height: button.width * 0.75

        anchors.centerIn: parent
        highlighted: true
        text: qsTr("Button")
        font.pointSize: 20

        onClicked: {
            if (button.font.pointSize <= 20 * 1.2 * 1.2)
                button.font.pointSize *= 1.2
            else
                button.font.pointSize = 20
        }
    }
}
