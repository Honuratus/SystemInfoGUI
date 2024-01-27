import QtQuick 2.15
import Qt5Compat.GraphicalEffects


Item {
    id: infoBox
    implicitWidth: 550
    implicitHeight: 30

    // Prop
    property int radiusValue: 10
    property color colorValue: "#AF0404"
    property color accentColorValue: "red"

    //Text Prop
    property string textValue: "Default"
    property color textColor: "#000000"
    property int textSize: 10
    property string fontFamily: "Arial"

    Rectangle {
        id: infoBoxRect
        width: infoBox.width
        height: infoBox.height

        anchors.centerIn: parent

        radius: infoBox.radiusValue
        color: infoBox.accentColorValue
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 0
            samples: 12
            color: Qt.rgba(0,0,0,0.3)
            spread: 0.2

        }
        Rectangle{
            anchors.centerIn: parent
            width: parent.width - 20
            height: parent.height

            color: infoBox.colorValue
            radius: parent.radius

        }
    }
    Text{
        id: infoBoxText
        text: infoBox.textValue
        font.pointSize: infoBox.textSize
        font.family: infoBox.fontFamily
        color: infoBox.accentColorValue

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        z:3
    }
}
