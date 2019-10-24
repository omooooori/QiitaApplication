import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 100
    height: 100

    readonly property alias containPress: mouseArea.containsPress

    property real inflateRatio: 0.0
    property bool locked: false
    property bool hasLightSource: true

    property alias source: image.source
    property alias sourceSize: image.sourceSize
    property alias maskSource: maskSource.source
    property real maskRatio: 0.9
    property alias foreground: foreground.color

    property bool checkable: false
    property bool checked: false

    onCheckedChanged: {
        if((locked || !checkable) && checked) {
            checked = false
            return
        }
    }

    signal pressed()
    signal released()
    signal clicked()

    state: locked ? 'lock' : (mouseArea.containsPress || checked ? 'active' : 'normal')

    // Need research
    DropShadow {
        visible: hasLightSource && root.state != 'active'
        anchors.fill: parent
        cached: true
        smooth: true
        horizontalOffset: 2
        verticalOffset: 2
        radius: 3
        source: image
    }

    Rectangle {
        id: foreground
        anchors.fill: parent
        color: "red"
        visible: false
    }

    // Need research
    OpacityMask {
        id: opacityMask
        visible: root.maskSource != ''
        anchors.centerIn: parent
        width: image.width * maskRatio
        source: foreground
        maskSource: Image {
            id: maskSource
            smooth: true
            visible: false
        }
    }

    Image {
        id: image
        anchors.fill: parent
        cache: true
        fillMode: Image.PreserveAspectFit
        visible: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        anchors.margins: -Math.min(parent.width, parent.height) * inflateRatio

        enabled: !locked

        onPressed: {
            root.pressed()
        }

        onReleased: {
            root.released()
        }

        onClicked: {
            if(checkable) {
                checked = checked
            }
            root.clicked()
        }
    }
}
