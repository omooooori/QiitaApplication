import QtQuick 2.9
import QtQuick.Controls 2.3

Page {
    id: root

    header: MyHeader{
        toolButtonIcon: "qrc:/images/arrow_back-24px.svg"
        onToolButtonClicked: root.StackView.view.pop()
    }

    property string text: "This is Animation Page !!"
    property bool animated: true
    focus:true

    Keys.enabled: true
    Keys.onBackPressed: {
        console.log("back key")
        root.StackView.view.pop()
    }
    Keys.onPressed: {
        if (event.key === Qt.Key_Delete || event.key === Qt.Key_Backspace)
            root.remove()
        else if (event.text !== "") {
            root.append(event.text)
        }
    }

    function append(text) {
        root.animated = false
        var lastLetter = root.children[root.children.length - 1]
        var newLetter = letterComponent.createObject(root)
        newLetter.text = text
        newLetter.follow = lastLetter
        root.animated = true
    }

    function remove() {
        if (root.children.length)
            root.children[root.children.length - 1].destroy()
    }

    function doLayout() {
        var follow = null
        for (var i = 0; i < root.text.length; ++i) {
            var newLetter = letterComponent.createObject(root)
            newLetter.text = root.text[i]
            newLetter.follow = follow
            follow = newLetter
        }
    }

    Component {
        id: letterComponent
        Text {
            id: letter
            property variant follow

            x: follow ? follow.x + follow.width : root.width / 6
            y: follow ? follow.y : root.height / 2

            font.pixelSize: 40;
            font.bold: true
            color: "grey";
            styleColor: "#222222";
            style: Text.Outline

            MouseArea {
                anchors.fill: parent
                drag.target: letter; drag.axis: Drag.XAndYAxis
                onPressed: letter.color = "#dddddd"
                onReleased: letter.color = "#999999"
            }

            Behavior on x { enabled: root.animated; SpringAnimation { spring: 3; damping: 0.3; mass: 1.0 } }
            Behavior on y { enabled: root.animated; SpringAnimation { spring: 3; damping: 0.3; mass: 1.0 } }
        }
    }

    Component.onCompleted: doLayout()
}
