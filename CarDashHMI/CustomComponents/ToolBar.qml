// ******************************************
// ** Tool Bar Component                   **
// ******************************************
//
// Author: Haseeb Tariq
// Date: August 31, 2023
//
// The Tool Bar component is a user interface element that provides essential information
// to users, including the current time, date, and ambient temperature. It includes the
// following elements:
//
// - 'clock': Displays the current time in the format "hh:mm".
// - 'temperature': Shows the ambient temperature, retrieved from OpenWeather, in Celsius.
// - 'date': Displays the current date in the format "MMM yy" (e.g., "Oct 23").
//
// Customize the appearance and content of the 'clock', 'temperature', and 'date' elements
// as needed to suit your application's design and functionality.
//
// The 'clock' element updates in real-time to reflect the current time, providing an
// accurate and dynamic display.
//
// Note: The temperature information is retrieved from OpenWeather and is subject to
// network availability and proper configuration.
//
// Licensing:
// This Bar Indicator component is open-source and available under the GNU General Public License (GPL).
//
// ******************************************


import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    anchors{
        top: parent.top
        horizontalCenter: parent.horizontalCenter
    }

    width: parent.width
    height: adaptive.height(70)
    z: parent.z +1
    opacity: 0.7

    Text {
        id: clock

        font.pointSize: adaptive.average(14)
        text: Qt.formatDateTime(new Date(), "hh:mm")
        color: "white"
        font.family: uniTextFont.name
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: adaptive.height(35)
        }
    }

    Text {
        id: temperature

        font.pointSize: adaptive.average(14)
        text: weather.temperatureCelsius.toFixed(0) == 0 ? "--"+"°C" : weather.temperatureCelsius.toFixed(0) +"°C"
        color: "white"
        font.family: uniTextFont.name
        anchors{
            verticalCenter: clock.verticalCenter
            left: clock.left
            leftMargin: adaptive.width(130)

        }
    }

    Text {
        id: date

        font.pointSize: adaptive.average(14)
        text: Qt.formatDateTime(new Date(), "MMM yy")
        color: "white"
        font.family: uniTextFont.name
        anchors{
            verticalCenter: clock.verticalCenter
            right: clock.right
            rightMargin: adaptive.width(130)
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
