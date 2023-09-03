import QtQuick 2.0
import QtQml 2.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.12

Item {
    width:  adaptive.width(500)
    height: adaptive.height(300)

    Text {
        id: menueName
        text: qsTr("Media")
        font.pixelSize: 30
        color: "snow"
        anchors{
            top: parent.top
            topMargin: 25
            horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle{
        width: 80
        height: 3
        color: "white"

        anchors{
            top: menueName.bottom
            topMargin: 5
            horizontalCenter: menueName.horizontalCenter
        }
    }

    Image {
        id: name
        x: 245
        y: 81
        width: 160
        height: 153
        source: "qrc:/Assets/Images/Media/MusicIcon.png"
        opacity: 0.4
    }

    Text {
        id: musicTitle
        color: "#fffafa"
        text: qsTr("I Can't Feel")
        anchors.top: parent.top
        font.pixelSize: 28
        anchors.horizontalCenterOffset: 61
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 161
    }

    Text {
        id: musicArtist
        color: "#fffafa"
        text: qsTr("Dua Lipa")
        font.pixelSize: 15
        anchors.leftMargin: 0
        anchors{
            left: musicTitle.left
            top: musicTitle.bottom
            topMargin: -1
        }
    }

    Image {
        id: art
        x: 116
        y: 102
        width: 111
        height: 111
        source: "qrc:/Assets/Images/Media/AlbumArt.png"
    }

    ProgressBar{
        id: control
        y: 240
        anchors.horizontalCenterOffset: 0

        width: 270
        height: 5
        value: 2.5
        to: 5
//            maximumValue: 100


        anchors{
            horizontalCenter: menueName.horizontalCenter

        }

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 6
            color: "#262626"
            radius: 3


        }

        contentItem: Item {
            implicitWidth: 200
            implicitHeight: 4

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

    Text {
        id: currentDuration
        text: control.value.toString().split(".")[0] +":"+ control.value.toFixed(1).toString().split(".")[1]
        font.pixelSize: 12
        color: "white"
        opacity: 0.5
        anchors{
            top: control.bottom
            topMargin: 5
            left: control.left

        }
    }

    Text {
        id: totalDuration
        text: qsTr("5:0")
        font.pixelSize: 12
        color: "white"
        opacity: 0.5
        anchors{
            top: control.bottom
            topMargin: 5
            right: control.right

        }
    }

    NumberAnimation{
        target: control
        property: "value"
        from: 1
        to: 3.1
        duration: 6000
        running: true

    }

}
