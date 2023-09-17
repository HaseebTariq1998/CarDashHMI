import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQml 2.3

Item{
    id: mainGauge

    property double value: 0
    property double maxValue: 8
    property alias glowColor: gaugeGlow.color
    property alias backgroundAsset: gaugeAsset.source
    property alias gaugeValueText: valueTitle.text
    property alias gaugeValueUnitText: valueUnit
    property alias gaugeShadow: gaugeGlow


    width: adaptive.width(391)
    height: adaptive.height(387)


    // Black drop shadow on Gauge
    DropShadow {
        id: gaugeGlow

        anchors.fill: mainGauge
        horizontalOffset: 3
//        verticalOffset: 3
        radius: 5
        spread: 0.1
        samples: 17
        color: "black"
        source: mainGauge
        opacity: 0.35
    }

    // Gauge digits markings
    PathView {
        id: digits

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: adaptive.height(-150)
        z: 1

        delegate: Text {
            id: digitsText

            text: digits.model[index]
            color: "#1f344d"
            font.pointSize: adaptive.average(12)
            opacity: 0.8
            font.family: uniTextFont.name
        }

        path: Path {
            startX: 0; startY: 0

            PathArc {
                x: 0; y: adaptive.height(300)
                radiusX: adaptive.width(125); radiusY: adaptive.height(125)
                direction: PathArc.Clockwise

            }

            PathArc {
                x: 0; y: 0
                radiusX: adaptive.width(125); radiusY: adaptive.height(125)
                direction: PathArc.Clockwise

            }
        }
    }


    // Gauge background
    Image {
        id: gaugeAsset

        source: "qrc:/Assets/Images/Gauge.png"
        height: adaptive.height(391)
        width: adaptive.width(387)
        anchors{
            centerIn: parent
        }
    }

    //Inner Black dial that shows guage value in text form
    Rectangle{
        id: centeralDialoutter

        anchors.centerIn: parent
        width: adaptive.average(150)
        height: adaptive.average(150)
        z: 3
        radius: 180
        color: "green"

        Rectangle{
            id: centralDialInner

            z: 1
            anchors.centerIn: parent
            width: adaptive.average(150)
            height: adaptive.average(150)
            radius: 180
            color: "black"

            // Gauge value in text
            Text {
                id: valueTitle

                text: value.toFixed(0)
                anchors.centerIn: parent
                color: "#b5b5b5"
                font.pointSize: adaptive.average(45)
                font.family: uniTextFont.name


                anchors.verticalCenterOffset: -5
            }

            // Value Unit
            Text {
                id: valueUnit

                text: "rpm/1000"
                color: "#b5b5b5"
                font.pointSize: adaptive.average(10)
                font.family: uniTextFont.name
                opacity: 0.8

                anchors{
                    horizontalCenter: valueTitle.horizontalCenter
                    top: valueTitle.bottom
                    topMargin: -10

                }
            }


        }


        // Glow effect on central dial
        RectangularGlow {
            id: effect

            anchors.fill: centeralDialoutter
            glowRadius: 50
            spread: 0.5
            color: "#24a9b8"
            cornerRadius: centeralDialoutter.radius + glowRadius
        }

    }

    Rectangle{
        id: needleElement

        property int angle: value/maxValue * 320

        anchors.centerIn: parent
        radius: 180
        width: adaptive.average(163)
        height: adaptive.average(163)
        rotation: -128 +angle
        color: "#307fd5"
        border.color: "#307fd5"
        z: 2

        // Needle asset
        Image {
            id: needleAsset

            x: adaptive.width(-29)
            y: adaptive.height(-77)
            width: adaptive.average(86)
            height: adaptive.average(98)

            source: "qrc:/Assets/Images/needle.png"
        }
    }

    Component.onCompleted:{

        var step = maxValue/8

        const newModel = [4,5,6,7,8,0,1,2,3];

        for (let i = 0 ; i <= 8; i++) {
            newModel[i] = newModel[i] * step
            console.log(newModel[i])
        }

        digits.model = newModel
    }

}
