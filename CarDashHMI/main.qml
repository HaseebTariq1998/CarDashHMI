import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

import "qrc:/CustomComponents"

ApplicationWindow {
    id: mainWindow

    width: 1219
    height: 487
    visible: true
    title: qsTr("CarDashHMI")

    background: Image {
        id: background
        source: "qrc:/Assets/Images/Background.png"
    }

    FontLoader {
           id: uniTextFont
           source: "qrc:/Assets/Fonts/Unitext Regular.ttf" // Path to your font file
       }

    Gauge{

        value: 4
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 59
        }


    }

    Gauge{

        x: 767
        y: 50
        value: 150
        maxValue: 280


    }



}
