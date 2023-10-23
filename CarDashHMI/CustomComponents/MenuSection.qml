// ******************************************
// ** Menu Section Component              **
// ******************************************
//
// Author: Haseeb Tariq
// Date: August 31, 2023
//
// This qml component contains the main stack view that load different menu pages which
// include map page and media page.
//
// Licensing:
// This Bar Indicator component is open-source and available under the GNU General Public License (GPL).
//
// ******************************************

import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQml 2.12
import "qrc:/CustomComponents/Pages"

Rectangle{

    property bool runMenuAnimation: false

    anchors.centerIn: parent
    width:  adaptive.width(500)
    height: adaptive.height(300)
    color: "black"
    visible: true
    clip: true

    // Main stack view of application
    StackView{
        id: mainApplicationStackView
        anchors.fill: parent

        // Sliding in animation
        pushEnter: Transition {
            NumberAnimation {
                properties: "x"
                from: mainApplicationStackView.width
                to: 0
                duration: 1000 // Milliseconds for push animation
                easing.type: Easing.InOutQuad
            }
        }

        // Sliding out animation
        pushExit: Transition {
            NumberAnimation {
                properties: "x"
                from: 0
                to: -mainApplicationStackView.width
                duration: 1000 // Milliseconds for push animation
                easing.type: Easing.InOutQuad
            }
        }
    }

    // Map Page
    PageMap{
        id: pageMap

        visible: false
    }

    // Media page
    PageMedia{
        id: pageMedia

        runMediaAnimation: runMenuAnimation
        visible: false
    }

    // Timer to switch media page with map page during demo animation
    Timer{
        id: pageShifTimer

        interval: 5000
        onTriggered: {
            mainApplicationStackView.push(pageMap)
            pageMap.startAnimation()
        }
    }

    Component.onCompleted: {
        mainApplicationStackView.push(pageMedia)
        pageShifTimer.running = runMenuAnimation
    }
}
