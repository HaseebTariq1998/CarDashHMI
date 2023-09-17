import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    anchors{
        top: parent.top
        horizontalCenter: parent.horizontalCenter
    }

    width: parent.width
    height: 70
    z:1000000000000
    opacity: 0.7

    Text {
        id: clock
        font.pointSize: 14
        text: Qt.formatDateTime(new Date(), "hh:mm")
        color: "white"
        font.family: uniTextFont.name
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 35
        }
    }

    Text {
        id: temperature
        font.pointSize: 14
        text: weather.temperatureCelsius.toFixed(0) == 0 ? "--"+"°C" : weather.temperatureCelsius.toFixed(0) +"°C"
        color: "white"
        font.family: uniTextFont.name
        anchors{
            verticalCenter: clock.verticalCenter
            left: clock.left
            leftMargin: 130

        }
    }

    Text {
        id: date
        font.pointSize: 14
        text: Qt.formatDateTime(new Date(), "MMM yy")
        color: "white"
        font.family: uniTextFont.name
        anchors{
            verticalCenter: clock.verticalCenter
            right: clock.right
            rightMargin: 130
        }
    }

    Timer
    {
        id: clockUpdate
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            clock.text = Qt.formatDateTime(new Date(), "hh:mm")
        }
    }

}
