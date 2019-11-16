import QtQuick 2.9

ListModel {
    ListElement {label: "Property Binding";  path: "PropertyBindingPage.qml";  icon: "qrc:/images/lock-24px.svg"}
    ListElement {label: "Layout";                    path: "LayoutPage.qml";                   icon: "qrc:/images/build-24px.svg"}
    ListElement {label: "Animation";              path: "AnimationPage.qml";            icon: "qrc:/images/adb-24px.svg"}
    ListElement {label: "Camera";                    path: "CameraPage.qml"}
//    ListElement {label: "Web View";              path: "WebViewPage.qml";              icon: "qrc:/images/build-24px.svg"}
    ListElement {label: "End";                         path: "";                                               icon: "qrc:/images/stop-24px.svg"}
}
