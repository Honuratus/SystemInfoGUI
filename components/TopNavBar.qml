import QtQuick 2.15

Item {
    id:topNavBar
    width: parent.width
    height: childrenRect.height
    //General
    property color rectColor: "#fff"
    property int spacingValue: 200

    // info rectangle
    property int rectWidth: topNavBar.width - 200
    property int rectHeight: 20

    //Close button
    property int buttonWidth: 20
    property int buttonHeight: 20

    //Title
    property string titleTextValue: "Window Title"
    property bool isVisible: true
    property color textColor: "black"

    Rectangle{
        width: topNavBar.rectWidth
        height: topNavBar.rectHeight
        color: topNavBar.rectColor
        radius: 15
        anchors.left: parent.left
        Text{
            color: topNavBar.textColor
            text: topNavBar.isVisible ? topNavBar.titleTextValue : ""
            font.bold: true
            font.family: "Arial"
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent

            property variant clickPos: "1,1"
            onPressed: {
                clickPos  = Qt.point(mouse.x,mouse.y)
            }

            onPositionChanged: {
                var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                rootWindow.x += delta.x;
                rootWindow.y += delta.y;
            }

        }

    }


}
