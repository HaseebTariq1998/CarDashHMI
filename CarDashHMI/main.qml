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

        value: 6
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: adaptive.width(59)
        }


    }

    Gauge{

        x: adaptive.width(767)
        y: adaptive.height(50)
        value: 200
        maxValue: 280


    }

}
