import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    id: root

    header: MyHeader{
        toolButtonIcon: "qrc:/images/arrow_back-24px.svg"
        onToolButtonClicked: root.StackView.view.pop()
    }

    focus:true
    Keys.enabled: true
    Keys.onBackPressed: {
        console.log("back key")
        root.StackView.view.pop()
    }

    GridLayout {
        id: grid
        anchors.fill: parent
        columns: 2
        rowSpacing: 5
        columnSpacing: 5
        anchors.margins: 5
        // example models
        property var titles: [ "title1", "title2", "title3", "title4", "title5" ]
        property var values: [ "value1", "value2", "value3", "value4", "value5" ]

        Repeater {
            model: grid.titles
            Label {
                Layout.row: index
                Layout.column: 0
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: modelData
            }
        }

        Repeater {
            model: grid.values
            TextArea {
                Layout.row: index
                Layout.column: 1
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: modelData
            }
        }
    }
}
