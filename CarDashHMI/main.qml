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

        value: 5
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: adaptive.width(59)
        }
    }

    NumberAnimation{
        duration: 5000
        properties: "value"
        from: 0
        to: 8
        target: rpm
        running: true
    }

    NumberAnimation{
        duration: 5000
        properties: "value"
        from: 100
        to: 0
        target: fuelBar
        running: true
    }

    Gauge{
        x: adaptive.width(767)
        y: adaptive.height(50)
        gaugeValueUnitText.text: "km/h"
        value: 200
        maxValue: 280
    }

    BarIndicator{
        id: fuelBar
        value: 50
        maxValue: 100

        x: adaptive.width(28)
        y: adaptive.height(289)
    }

    BarIndicator{
        id: temperatureBar

        x: adaptive.width(mainWindow.width - 27)
        y: adaptive.height(289)

        transform: [
            Scale{ xScale: -1}
        ]
    }

}
