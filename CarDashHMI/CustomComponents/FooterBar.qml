// ******************************************
// ** App Footer Component                 **
// ******************************************
//
// Author: Haseeb Tariq
// Date: September 1, 2023
//
// The App Footer component provides a customizable footer section for your application,
// typically used to display information such as range and odometer values. This component
// includes two text elements:
//
// - 'range': Displays a numeric value, such as a range in miles or kilometers.
// - 'odometer': Shows an odometer reading, often used for tracking distance.
//
// Customize the appearance and content of the 'range' and 'odometer' text elements as
// needed to suit your application's requirements.
//
// Licensing:
// This App Footer component is open-source and available under the GNU General Public License (GPL).
//
// ******************************************
import QtQuick 2.0

Item {
    id: mainFooter

    property alias range: rangeValue.text
    property var odometer : 0

    height: parent.height * 0.18
    width: parent.width

    Text {
        id: rangeValue

        font.pointSize: adaptive.average(13)
        text: "156"
        color: "white"
        font.family: uniTextFont.name
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: adaptive.height(39)
            horizontalCenterOffset: adaptive.height(163)
        }
    }

    Text {
        id: odometerValue

        font.pointSize: adaptive.average(13)
        text: (odometer).toString().padStart(6, '0');
        color: "white"
        font.family: uniTextFont.name
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: adaptive.height(39)
        }
    }
}
