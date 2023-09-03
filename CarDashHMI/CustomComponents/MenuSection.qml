import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQml 2.12
import "qrc:/CustomComponents/Pages"

Rectangle{
    anchors.centerIn: parent
    width:  adaptive.width(500)
    height: adaptive.height(300)
    color: "black"
    visible: true
    clip: true

    StackView{
        id: mainApplicationStackView
        anchors.fill: parent

        pushEnter: Transition {
            NumberAnimation {
                properties: "x"
                from: mainApplicationStackView.width
                to: 0
                duration: 1000 // Milliseconds for push animation
                easing.type: Easing.InOutQuad
            }
        }



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


    PageMap{
        id: pageMap
        visible: false
    }

    PageMedia{
        id: pageMedia
        visible: false
    }

    Timer{
        id: pageShifTimer
        interval: 3000
        onTriggered: {
            mainApplicationStackView.push(pageMap)
            pageMap.startAnimation()
        }
    }

    Component.onCompleted: {
        mainApplicationStackView.push(pageMedia)
        pageShifTimer.running = true

    }
}
