// ******************************************
// ** Media Player Page                   **
// ******************************************
//
// This QML page simulates a media player interface. It includes visual elements such as
// album art, song title, artist name and a progress bar. The animated
// progress bar emulates the play progress of a track.
//
// Customize the appearance and content of the elements to create an engaging media player
// experience for your application.
//
// ******************************************

import QtQuick 2.0
import QtQml 2.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.12

Item {
    id: pageMap

    property alias runMediaAnimation: mediaAnimation.running

    width:  adaptive.width(500)
    height: adaptive.height(300)


    // Main title of page
    Text {
        id: menuName

        text: qsTr("Media")
        font.pixelSize: adaptive.average(30)
        color: "snow"
        anchors{
            top: parent.top
            topMargin: adaptive.height(25)
            horizontalCenter: parent.horizontalCenter
        }
    }

    // White line below the main title
    Rectangle{
        id: line

        width: adaptive.width(80)
        height: adaptive.height(3)
        color: "white"
        anchors{
            top: menuName.bottom
            topMargin: adaptive.height(5)
            horizontalCenter: menuName.horizontalCenter
        }
    }

    // Music note icon embedded in the background
    Image {
        id: musinIcon

        x: adaptive.width(245)
        y: adaptive.height(81)
        width: adaptive.width(160)
        height: adaptive.height(153)
        source: "qrc:/Assets/Images/Media/MusicIcon.png"
        opacity: 0.4
    }

    // Song title
    Text {
        id: musicTitle

        color: "#fffafa"
        text: qsTr("I Can't Feel")
        anchors.top: parent.top
        font.pixelSize: adaptive.average(28)
        anchors{
            horizontalCenter: parent.horizontalCenter
            topMargin: adaptive.height(161)
            horizontalCenterOffset: adaptive.width(61)
        }

    }

    // Song artist
    Text {
        id: musicArtist

        color: "#fffafa"
        text: qsTr("Dua Lipa")
        font.pixelSize: adaptive.average(15)
        anchors{
            left: musicTitle.left
            top: musicTitle.bottom
            topMargin: -adaptive.height(1)
        }
    }

    // Album Art
    Image {
        id: art

        x: adaptive.width(116)
        y: adaptive.height(102)
        width: adaptive.width(111)
        height: adaptive.width(111)
        source: "qrc:/Assets/Images/Media/AlbumArt.png"
    }

    // Progress bar to show the progress of track
    ProgressBar{
        id: control

        y: adaptive.height(240)
        width: adaptive.width(270)
        height: adaptive.height(5)
        value: 2.5
        to: 5
        anchors{
            horizontalCenter: menuName.horizontalCenter
        }

        background: Rectangle {
            implicitWidth: adaptive.width(200)
            implicitHeight: adaptive.height(6)
            color: "#262626"
            radius: 3
        }

        contentItem: Item {
            implicitWidth: adaptive.width(200)
            implicitHeight: adaptive.height(4)

            Rectangle {
                width: control.visualPosition * parent.width
                height: parent.height
                radius: 2
                color: "#5B7DFA"

                RectangularGlow {
                    id: effect
                    anchors.fill: parent
                    glowRadius: 10
                    spread: 0.2
                    color: "#5B7DFA"
                    opacity: 0.5
                    z:-1
                    cornerRadius: parent.radius + glowRadius
                }
            }
        }
    }

    // Current duration of track
    Text {
        id: currentDuration

        text: control.value.toString().split(".")[0] +":"+ control.value.toFixed(1).toString().split(".")[1]
        font.pixelSize: adaptive.average(12)
        color: "white"
        opacity: 0.5
        anchors{
            top: control.bottom
            topMargin: adaptive.height(5)
            left: control.left
        }
    }

    // Total length of track
    Text {
        id: totalDuration

        text: qsTr("5:0")
        font.pixelSize: adaptive.average(12)
        color: "white"
        opacity: 0.5
        anchors{
            top: control.bottom
            topMargin: adaptive.height(5)
            right: control.right
        }
    }

    // Animation to simulate the song playing
    NumberAnimation{
        id: mediaAnimation

        target: control
        property: "value"
        from: 1
        to: 3.1
        duration: 6000
        running: true
    }

}
