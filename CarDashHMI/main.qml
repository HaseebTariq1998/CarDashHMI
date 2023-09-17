import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQml 2.3

import "qrc:/CustomComponents"

import "qrc:/JavascriptScripts/AdaptiveLayoutManager.js" as Responsive

ApplicationWindow {
    id: mainWindow

    width: 1219
    height: 487
    visible: true
    title: qsTr("CarDashHMI")
    property var adaptive: new Responsive.AdaptiveLayoutManager(1219,487, mainWindow.width,mainWindow.height)

    onWidthChanged: {
        if(adaptive)
        adaptive.updateWindowWidth(mainWindow.width)
    }

    onHeightChanged: {
        if(adaptive)
        adaptive.updateWindowHeight(mainWindow.height)
    }

    background: Image {
        id: background
        width: adaptive.width(1219)
        height: adaptive.height(487)
        source: "qrc:/Assets/Images/Background.png"
    }

    FontLoader {
           id: uniTextFont
           source: "qrc:/Assets/Fonts/Unitext Regular.ttf" // Path to your font file
       }

    Gauge{
        id: rpm

        value: 0
        z: 2
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: adaptive.width(59)
        }
    }

    SequentialAnimation{
        loops: Animation.Infinite
                running: true

        NumberAnimation{
            duration: 17000
            properties: "value"
            from: 0
            to: 7
            target: rpm

            easing.type:Easing.OutInQuad // Easing.OutInSine // Easing.InOutSine

        }

//                NumberAnimation{
//                    duration: 3000
//                    properties: "value"
//                    to: 3
//                    target: rpm


//                }

//                NumberAnimation{
//                    duration: 1000
//                    properties: "value"
//                    from: 3
//                    to: 2.8
//                    target: rpm


//                }

//                NumberAnimation{
//                    duration: 5000
//                    properties: "value"
//                    to: 5
//                    target: rpm


//                }

//                NumberAnimation{
//                    duration: 1000
//                    properties: "value"
//                    from: 5
//                    to: 4.8
//                    target: rpm


//                }

//                NumberAnimation{
//                    duration: 7000
//                    properties: "value"
//                    to: 7
//                    target: rpm


//                }

        NumberAnimation{
            duration: 10000
            properties: "value"
            to: 0
            target: rpm


        }

    }

SequentialAnimation{
    loops: Animation.Infinite
            running: true

    NumberAnimation{
        duration: 17000
        properties: "value"
        from: 0
        to: 210
        target: speed

        easing.type:Easing.InOutQuad

    }

    NumberAnimation{
        duration: 10000
        properties: "value"
        to: 0
        target: speed


    }


//    NumberAnimation{
//        duration: 10000
//        properties: "value"
//        from: 3
//        to: 6
//        target: rpm

////        easing.type: Easing.OutQuad

//    }

//    NumberAnimation{
//        duration: 15000
//        properties: "value"
//        from: 6
//        to: 7
//        target: rpm

////        easing.type: Easing.OutQuad

//    }


}


SequentialAnimation{

    running: true
    loops: Animation.Infinite

    NumberAnimation{
        duration: 5000
        properties: "value"
        from: 0
        to: 100
        target: fuelBar
    }
    NumberAnimation{
        duration: 5000
        properties: "value"
        from: 100
        to: 0
        target: fuelBar
    }
}

    Gauge{
        id: speed
        x: adaptive.width(767)
        y: adaptive.height(50)
        z: 2
        gaugeValueUnitText.text: "km/h"
        gaugeValueText: value.toFixed(0) % 5 == 0 ? value.toFixed(0) : speed.gaugeValueText
        value: 200
        maxValue: 280
        gaugeShadow.horizontalOffset: -3
    }

    BarIndicator{
        id: fuelBar
        value: 100
        maxValue: 100

        x: adaptive.width(28)
        y: adaptive.height(289)
    }

    BarIndicator{
        id: temperatureBar

        x: adaptive.width(mainWindow.width - 27)
        y: adaptive.height(289)
        maxValue: 100
        value: 30

        transform: [
            Scale{ xScale: -1}
        ]
    }

    MenuSection{
    }

    ToolBar{

    }

    Text {
        id: date
        font.pointSize: 11
        text: "156"
        color: "white"
        font.family: uniTextFont.name
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 39
            horizontalCenterOffset: 163
        }
    }

    Text {
        id: range
        font.pointSize: 11
        text: "000000"
        color: "white"
        font.family: uniTextFont.name
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 39
        }
    }

}
