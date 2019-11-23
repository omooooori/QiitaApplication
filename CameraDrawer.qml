import QtQuick 2.9

import CameraControl 1.0

Item {
    id: drawer

    readonly property bool open: y == 0

    property real lastY: height - quickSettingsHeight
    property real quickSettingsHeight: 0.1 * parent.height

    property real opacityCalc: 0.6 * Math.sqrt(drawerPosition)
    property real drawerPosition: 1 - (y / (height - quickSettingsHeight))

    property int orientation: 0
    property CameraControl config

    anchors {
        left: parent.left
        right: parent.right
    }

    height: parent.height
    y: 0.9 * parent.height

    CameraControl {
        id: controller
    }

    Drag.active: dragArea.drag.active || dragArea2.drag.active
    Drag.onDragFinished: {
            if (drawerPosition > 0.5)
                openDrawer();
            else
                closeDrawer();

            console.log("Drag finished");
    }

    Behavior on y {
        PropertyAnimation { easing: Easing.OutQuad }
    }

    Rectangle {
        id: background

        anchors.fill: parent

        color: "#000000"
        opacity: parent.opacityCalc
    }

    MouseArea {
        id: dragArea

        anchors.fill: parent

        drag {
            axis: Drag.YAxis
            target: parent
            minimumY: 0
            maximumY: parent.height - parent.quickSettingsHeight
            filterChildren: true
        }

        MouseArea {
            id: dragArea2

            anchors.fill: parent

            drag {
                axis: Drag.YAxis
                target: drawer
                minimumY: 0
                maximumY: drawer.height - drawer.quickSettingsHeight
            }
        }

        Item {
            id: quickSettingsBack

            anchors {
                top: parent.top
                right: parent.right
                left: parent.left
            }

            height: drawer.quickSettingsHeight

            IconWidget {
                id: flashIcon

                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }

                scale: 0.75

                iconName: controller.getFlashName(controller.flashType)

                onClicked: {
                    if (controller.flashType < 2)
                        controller.flashType++;
                    else
                        controller.flashType = 0;
                }
            }

            IconWidget {
                id: whiteBalanceIcon

                anchors {
                    left: flashIcon.right
                    top: parent.top
                    bottom: parent.bottom
                }

                scale: 0.75

                iconName: controller.getWhiteBalance(controller.whiteBalance)

                onClicked: {
                    if (controller.whiteBalance < 4)
                        controller.whiteBalance++;
                    else
                        controller.whiteBalance = 0;
                }
            }

            IconWidget {
                id: switchModeIcon

                anchors {
                    right: switchCamIcon.left
                    top: parent.top
                    bottom: parent.bottom
                }

                scale: 0.75

                iconName: controller.isCameraMode === true ? "switch-video" : "switch-camera"

                onClicked: {
                    if (controller.isCameraMode === true)
                        controller.isCameraMode = false;
                    else
                        controller.isCameraMode = true;
                }
            }

            IconWidget {
                id: switchCamIcon

                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }

                scale: 0.75

                iconName: controller.isFrontCamera === true ? "camera-front" : "camera-rear"

                onClicked: {
                    if (controller.isFrontCamera === true)
                        controller.isFrontCamera = false;
                    else
                        controller.isFrontCamera = true;
                }
            }
        }

        Item {
            id: drawerContents

            anchors {
                top: quickSettingsBack.bottom
                right: parent.right
                left: parent.left
                bottom: parent.bottom
            }
        }
    }

    function openDrawer()
    {
        y = 0;
        lastY = y;
    }

    function closeDrawer()
    {
        y = height - quickSettingsHeight;
        lastY = y;
    }

    function returnToNearest()
    {
        if (drawerPosition < 0.5)
            closeDrawer();
        else
            openDrawer()
    }
}
