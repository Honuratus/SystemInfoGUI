import QtQuick 2.15
import QtQuick.Shapes 1.15
import Qt5Compat.GraphicalEffects


Item {

    //Width and height
    property real widthValue: 250
    property real heightValue: 250

    id: progress
    implicitWidth: widthValue
    implicitHeight: heightValue
    antialiasing: true


    //General
    property bool spRoundCap: true
    property int startAngle: -90
    property real maxValue: 100
    property real value: 100
    property int samples: 20
    //Properties
    property color bgColor: "transparent"
    property color bgStrokeColor: "#7e7e7e"
    property int bgStrokeWidth: 8

    //Progress Circle
    property color progressColor: "#55aaff"
    property int progressWidth: 8

    //Text
    property string textValue: "%"
    property bool textShowValue: true
    property string fontFamily: "Segoe UI"
    property int textSize: 12
    property color textColor: "#7c7c7c"

    //Property title text
    property string titleTextValue: ""
    property string titleFontFamily: "Segoe UI"
    property int titleTextSize: 12;
    property color titleTextColor: "#fff"
    property bool isBold: true

    Shape{
        id: shape
        anchors.fill: parent
        layer.enabled: true
        //layer.samples: progress.samples
        antialiasing: true
        smooth: true

        ShapePath{
            id:pathBg
            strokeColor: progress.bgStrokeColor
            fillColor: progress.bgColor
            strokeWidth: progress.bgStrokeWidth
            capStyle: progress.spRoundCap ? ShapePath.RoundCap : ShapePath.FlatCap

            PathAngleArc{
                radiusX: (progress.width / 2) - (progress.progressWidth / 2)
                radiusY: (progress.height / 2) - (progress.progressWidth / 2)
                centerX: progress.width / 2
                centerY: progress.height / 2
                startAngle: progress.startAngle
                sweepAngle: 360

            }
        }

        ShapePath{
            id:path
            strokeColor: progress.progressColor
            fillColor: "transparent"
            strokeWidth: progress.bgStrokeWidth
            capStyle: progress.spRoundCap ? ShapePath.RoundCap : ShapePath.FlatCap

            PathAngleArc{
                radiusX: (progress.width / 2) - (progress.progressWidth / 2)
                radiusY: (progress.height / 2) - (progress.progressWidth / 2)
                centerX: progress.width / 2
                centerY: progress.height / 2
                startAngle: progress.startAngle
                sweepAngle: (360 / progress.maxValue * progress.value)
            }
        }
        Text{
            id:textProgress
            text: progress.textShowValue ? parseInt(progress.value) + progress.textValue : progress.textValue
            font.family: progress.fontFamily
            font.pointSize: progress.textSize
            color: progress.textColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        Text{
            id: titleProgress
            color: progress.titleTextColor
            font.family: progress.titleFontFamily
            text: progress.titleTextValue
            anchors.top: textProgress.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: progress.titleTextSize
            anchors.topMargin: 15
        }
    }

}
