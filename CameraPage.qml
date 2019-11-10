import QtQuick 2.9
import QtQuick.Controls 2.3
import QtMultimedia 5.4

Page {
    id: root

    header: MyHeader{
        toolButtonIcon: "qrc:/images/arrow_back-24px.svg"
        onToolButtonClicked: root.StackView.view.pop()
    }

    state: "PhotoCapture"
    states: [
        State {
            name: "PhotoCapture"
            StateChangeScript {
                script: {
                    camera.captureMode = Camera.CaptureStillImage
                    camera.start()
                }
            }
        },
        State {
            name: "PhotoPreview"
        }
    ]

    Camera {
        id: camera
        captureMode: Camera.CaptureStillImage

        imageCapture {
            onImageCaptured: {
                photoPreview.source = preview
                stillControls.previewAvailable = true
                root.state = "PhotoPreview"
            }
        }
    }

    PhotoPreview {
        id: photoPreview
        anchors.fill: parent
        onClosed: root.state = "PhotoCapture"
        visible: root.state == "PhotoPreview"
        focus: visible
    }

}
