import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQml 2.3

import "qrc:/CustomComponents"
import "qrc:/JavascriptScripts/AdaptiveLayoutManager.js" as Responsive

ApplicationWindow {
    id: mainWindow


    property var adaptive: new Responsive.AdaptiveLayoutManager(1219,487, mainWindow.width,mainWindow.height)

    // Properties to test different UI components
    property bool runAnimations: true // To assigne value to different UI component , set it false
    property double speedValue: 150 //  Range [0 ~ 280] ( range can be change in component properties )
    property double rpmValue: 4 //  Range [0 ~ 8] ( range can be change in component properties )
    property double fuelBarValue: 50  // Range [0 ~ 100] ( range can be change in component properties )
    property double temperatureBarValue: 50  // Range [0 ~ 100] ( range can be change in component properties )

    width: 1219
    height: 487
    visible: true
    title: qsTr("CarDashHMI")

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

    // Font loader contaning the font sources that are used in application
    FontLoader {
        id: uniTextFont

        source: "qrc:/Assets/Fonts/Unitext Regular.ttf"
    }

    // Tool bar to display Date , time and  ambient temperature
    ToolBar{
        id: toolBar
    }

    // RPM Gauge for value (set 'value') within a range (0 to max 'maxValue')
    Gauge{
        id: rpmGauge

        x: adaptive.width(59)
        y: adaptive.height(50)
        z: 2
        gaugeValueUnitText.text: "rpm/1000"
        gaugeValueText: value.toFixed(0)
        value: mainWindow.rpmValue
        maxValue: 8
    }

    // Speed Gauge for value (set 'value') within a range (0 to max 'maxValue')
    Gauge{
        id: speedGauge

        x: adaptive.width(767)
        y: adaptive.height(50)
        z: 2
        gaugeValueUnitText.text: "km/h"
        gaugeValueText: value.toFixed(0) % 5 == 0 ? value.toFixed(0) : speedGauge.gaugeValueText
        value: 200
        maxValue: 280
        gaugeShadow.horizontalOffset: -3
    }

    // Fuel Bar Indicator (set 'value' within the range [ 0 to 'max'] using 'maxValue').
    BarIndicator{
        id: fuelBar

        value: 100
        maxValue: 100
        x: adaptive.width(28)
        y: adaptive.height(289)
    }

    // Temperature Bar Indicator (set 'value' within the range [ 0 to 'max'] using 'maxValue').\
    BarIndicator{
        id: temperatureBar

        x: adaptive.width(1192)
        y: adaptive.height(289)
        maxValue: 100
        value: 80
        leftMirrorInvert: true
    }

    // Menu section that has stack view to show Media player and Maps
    // runMenuAnimation: argument turn on and off animation of both Media player and maps
    MenuSection{
        id: menuSection

        runMenuAnimation: runAnimations
    }


    // Demo component to animate speed gauge , rpm gauge and fuel bar indicator
    DemoAnimation{
        id: demoAnimation

        runAnimation: runAnimations
    }

    FooterBar{
        id: footerbar

        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }
}
