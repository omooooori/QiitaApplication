import QtQuick 2.9
import QtQuick.Controls 2.3
import QtMultimedia 5.4

import CameraControl 1.0

Page {
    id: root

    header: MyHeader{
        toolButtonIcon: "qrc:/images/arrow_back-24px.svg"
        onToolButtonClicked: root.StackView.view.pop()
    }

    CameraControl {
        id: controller
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

    VideoOutput {
         id: videoOutput
         source: camera
         anchors.top: parent.top
         anchors.topMargin: 100
         focus : true

        Slider {
              id:zoomSlider
              orientation: Qt.Vertical
              stepSize: camera.maximumDigitalZoom/10   // going through 10 steps
              value: 1.0                               // initial zoom level
              anchors{
                  left: parent.left
                  leftMargin: 5
                  bottom: parent.bottom
                  bottomMargin: 5
              }
          }
    }

    Camera {
        id: camera
        captureMode: Camera.CaptureStillImage

        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

        position: controller.isFrontCamera ? Camera.FrontFace : Camera.BackFace

        exposure {
            exposureCompensation: 0
            exposureMode: Camera.ExposurePortrait
        }

        imageCapture {
            onImageCaptured: {
                photoPreview.source = preview
                root.state = "PhotoPreview"
            }
        }

        Component.onCompleted: {
            getFlash();
            getWhiteBalance();
        }

        function getFlash ()
        {
            switch (controller.flashType)
            {
            case 0:
                flash.mode = Camera.FlashOff;
                break;
            case 1:
                flash.mode = Camera.FlashAuto;
                break;
            case 2:
                flash.mode = Camera.FlashOn;
                break;
            }
        }

        function getWhiteBalance ()
        {
            switch (controller.whiteBalance)
            {
            case 0:
                imageProcessing.whiteBalanceMode = CameraImageProcessing.WhiteBalanceAuto;
                console.log("Auto White Balance")
                break;
            case 1:
                imageProcessing.whiteBalanceMode = CameraImageProcessing.WhiteBalanceCloudy;
                console.log("Cloudy White Balance")
                break;
            case 2:
                imageProcessing.whiteBalanceMode = CameraImageProcessing.WhiteBalanceFluorescent;
                console.log("Fluorescent White Balance")
                break;
            case 3:
                imageProcessing.whiteBalanceMode = CameraImageProcessing.WhiteBalanceSunlight;
                console.log("Sunlight White Balance")
                break;
            case 4:
                imageProcessing.whiteBalanceMode = CameraImageProcessing.WhiteBalanceTungsten;
                console.log("Tungsten White Balance")
                break;
            }
        }
    }

    FloatingActionButton {
        id: cameraAction

        z: 10
        visible: !drawer.open

        scale: 1-drawer.drawerPosition
        opacity: drawer.drawerPosition < 0.25 ? 1-(4 * drawer.drawerPosition) : 0

        iconName: controller.isCameraMode === true ? "capture" : (camera.videoRecorder.recorderState == CameraRecorder.StoppedState ? "record" : "stop")
        color: controller.isCameraMode === true ? "#0099CC" : "#CC0000"

        onClicked: {
            if (controller.isCameraMode === true)
                camera.imageCapture.capture();
            else
            {
                if (camera.videoRecorder.recorderState == CameraRecorder.StoppedState)
                    camera.videoRecorder.record();
                else
                    camera.videoRecorder.stop();
            }
        }
        Behavior on rotation {
            RotationAnimation { easing: Easing.InOutQuad }
        }
    }

    ShutterFlash {
        id: shutter
        z: 1
        anchors.horizontalCenter: cameraAction.horizontalCenter
        anchors.verticalCenter: cameraAction.verticalCenter
    }

    CameraDrawer {
        id: drawer
        config: controller
    }

    PhotoPreview {
        id: photoPreview
        anchors.fill: parent
        onClosed: root.state = "PhotoCapture"
        visible: root.state == "PhotoPreview"
        focus: visible
    }
}
