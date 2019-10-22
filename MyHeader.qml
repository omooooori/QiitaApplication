import QtQuick 2.9
import QtQuick.Controls 2.3

ToolBar {
    property string toolButtonIcon: toolButton.icon.source

    signal toolButtonClicked

    ToolButton {
        id: toolButton
        icon.source: toolButtonIcon
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        onClicked: toolButtonClicked()
    }
    Label {
        anchors.centerIn: parent
        text: qsTr("Qiita Application")
        font.pixelSize: 16
        elide: Label.ElideRight
    }
}
