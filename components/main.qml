import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects


Window {

    property color accentColor: "#FF0000"
    property color bgColor : "#252525"
    property color mainColor: "#171717"

    id: rootWindow
    visible: true
    width: 600
    height: 720
    title: "Canvas Animation Example"
    color: 'transparent'
    flags: Qt.FramelessWindowHint | Qt.Window

    // Filler Rectangle
    Rectangle{
        anchors.fill: parent
        color: rootWindow.bgColor
        radius: 20
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 0
            samples: 17
            color: Qt.rgba(0,0,0,0.5)
            spread: 0.2

        }
    }

    //Window hint
    TopNavBar{
        id:topNavBar
        width: 800
        height: 24
        rectColor: rootWindow.accentColor
        titleTextValue: 'System Monitor'
        textColor: rootWindow.bgColor
    }



    Column{
        width: rootWindow.width
        anchors.top: topNavBar.bottom
        anchors.topMargin: 20
        spacing: 20

        InfoHeaderBox{
            textValue: "Cpu"
            colorValue: "black"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Repeater{
            id: repeater
            model:["CPU Brand:", "Physical Core:","Frequency:"]
            InfoBox{
                textValue: modelData + " " +repeater.valueList[index]
                colorValue: rootWindow.mainColor
                textColor: "red"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            property var valueList: [cpuMonitor.cpu_brand, cpuMonitor.cpu_core, cpuMonitor.cpu_freq]
        }
        InfoHeaderBox{
            textValue: "Gpu"
            colorValue: "black"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Repeater{
            id: repeaterGpu
            model:["GPU Brand:", "Vram:","Temp:"]
            InfoBox{
                textValue: modelData + " " +repeaterGpu.valueList[index]
                colorValue: rootWindow.mainColor
                textColor: "red"
                anchors.horizontalCenter: parent.horizontalCenter


            }
            property var valueList: [gpuMonitor.gpu_brand, gpuMonitor.gpu_vram,""]
        }
        InfoHeaderBox{
            textValue: "Memory"
            colorValue: "black"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Repeater{
            model:["Memory:"]
            InfoBox{
                textValue: modelData + " " + memMonitor.total_memory
                colorValue: rootWindow.mainColor
                textColor: "red"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }





    //Percantage Bars
    GridLayout {
        id: bottomBars
        rows: 1
        columns: 3
        columnSpacing: 30

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        CircularProgressBar{
            id: cpuCpb
            widthValue: 125
            heightValue: 125
            bgStrokeWidth: 4
            progressWidth: 4
            bgStrokeColor: rootWindow.mainColor


            value: 0
            progressColor: rootWindow.accentColor



            titleTextColor: rootWindow.accentColor
            titleTextSize: 10
            titleTextValue: "CPU"
            Component.onCompleted: {
                cpuMonitor.update_cpu_usage()
                cpuMonitor.start_monitoring()
            }
        }

        CircularProgressBar{
            id: gpuCpb
            widthValue: 125
            heightValue: 125
            bgStrokeWidth: 4
            progressWidth: 4
            bgStrokeColor: rootWindow.mainColor


            value: 0
            progressColor: rootWindow.accentColor


            //title
            titleTextColor: rootWindow.accentColor
            titleTextSize: 10
            titleTextValue: "GPU"

            Component.onCompleted: {
                gpuMonitor.update_gpu_info()
                gpuMonitor.start_monitoring()
            }

        }

        CircularProgressBar{
            id: memCpb
            widthValue: 125
            heightValue: 125
            bgStrokeWidth: 4
            progressWidth: 4
            bgStrokeColor: rootWindow.mainColor


            value: 0
            progressColor: rootWindow.accentColor

            //title
            titleTextColor: rootWindow.accentColor
            titleTextSize: 10
            titleTextValue: "Mem"
            Component.onCompleted: {
                memMonitor.update_mem_usage()
                memMonitor.start_monitoring()
            }

        }
    }

    // Backend frontend acces
    Connections{
        target: cpuMonitor
        function onCpuUsageChanged(usage){
            // Create a new NumberAnimation every time the signal is emitted
            var animation = Qt.createQmlObject('
                import QtQuick 2.15

                NumberAnimation {
                target: cpuCpb
                properties: "value"
                from: cpuCpb.value
                to:' + usage + '
                duration: 1000
                easing.type: Easing.OutQuad}',
                                               cpuCpb
                                               );
            // Start the animation
            animation.start();
        }

    }

    Connections{
        target: gpuMonitor
        function onGpuUsageChanged(usage){
            // Create a new NumberAnimation every time the signal is emitted
            var animation = Qt.createQmlObject('
                import QtQuick 2.15

                NumberAnimation {
                target: gpuCpb
                properties: "value"
                from: gpuCpb.value
                to:' + usage + '
                duration: 1000
                easing.type: Easing.OutQuad}',
                gpuCpb
                );
            // Start the animation
            animation.start();
        }
        function onGpuTempChanged(temp){
            repeaterGpu.itemAt(2).textValue = "Temp: " +  temp
        }
    }
    Connections{
        target: memMonitor
        function onMemUsageChanged(usage){
            // Create a new NumberAnimation every time the signal is emitted
            var animation = Qt.createQmlObject('
                import QtQuick 2.15

                NumberAnimation {
                target: memCpb
                properties: "value"
                from: memCpb.value
                to:' + usage + '
                duration: 1000
                easing.type: Easing.OutQuad}',
                memCpb
                );
            // Start the animation
            animation.start();
        }

    }

}
