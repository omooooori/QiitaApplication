import QtQuick 2.9
import QtQuick.Controls 2.3

ApplicationWindow {
    id: root

    visible: true
    width: 540
    height: 960

    background: BackgroundPage {}

    StackView {
        id: stackView
        anchors.fill: parent
        background: root.background
        initialItem: MainPage {}
        Component.onCompleted: console.log("background = ", root.background)
    }

}
