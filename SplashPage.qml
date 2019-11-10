import QtQuick 2.9
import QtQuick.Layouts 1.3

Item {
    id: root
    width: 540
    height: 960

    // Display a little message to the user while loading...
    // ...

    Image {
        width: 400
        height: 400
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        clip: true
        source: "qrc:/images/DotPicture.png"
    }

    // This is the Loader that will load the main.qml file
    Loader {
        id: main
        anchors.fill: parent
        asynchronous: true
        visible: status == Loader.Ready
    }

    // This is a fake delay needed to give to QML the necessary time
    // to load and setup the splash item above
    PauseAnimation {
        id: fakeLoadingDelay
        duration: 50
        onRunningChanged: {
            if ( !running ) {
                // Call the init() function of SplashShow
                SplashShow.init();

                console.log("Inside Puase Animation")

                // When the init() returns, load main.qml
                main.source = "main.qml"
            }
        }
    }

    // This start the animation and loading of mail.qml when the component is ready
    Component.onCompleted: fakeLoadingDelay.start()
}
