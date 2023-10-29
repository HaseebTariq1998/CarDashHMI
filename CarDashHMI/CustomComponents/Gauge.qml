// ******************************************
// ** Custom Gauge Component Usage        **
// ******************************************
//
// Author: Haseeb Tariq
// August 30, 2023
//
// The custom Gauge component is a versatile visual element.
// It is designed for displaying values within a specified range and offers a rich set of
// features for creating engaging user interfaces with data visualization capabilities.
//
// Key Features:
// - Position the Gauge within your UI for optimal presentation.
// - Set the 'value' property to display a specific data point on the Gauge.
// - Define the 'maxValue' to establish the upper limit of the displayed range.
// - Customize the text that appears on the central dial for informative labels.
// - alertThemeActivate flag allow the change of theme from aqua to orange
// - Specify the unit of measurement (e.g., "rpm/1000") to accompany the value.
// - Optionally, fine-tune the visual appeal with customizable 'glowColor' and 'backgroundAsset'.
//
// Licensing:
// This Gauge component is open-source and available under the GNU General Public License (GPL).
//
// ******************************************

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
    property bool alertThemeActivate : false

    width: adaptive.width(391)
    height: adaptive.height(387)


    // Gauge background
    Item {
        id: gaugeBackGround

        anchors.fill: parent

        // Gauge Image in background has gauge griding
        Image {
            id: gaugeAsset

            source: "qrc:/Assets/Images/Gauge.png"
            height: adaptive.height(391)
            width: adaptive.width(387)
            z: -1
            anchors{
                centerIn: parent
            }
        }

        // Glow on outer border of gauge
        Rectangle {
            id: backgroundGlowGradinet

            width: adaptive.width(388)
            height: adaptive.height(387)
            radius: 180
            visible: false
            color: "transparent"
            anchors.centerIn: parent

            RadialGradient {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: "transparent"
                    }
                    GradientStop {
                        position: 0.34
                        color: "transparent"
                    }
                    GradientStop {
                        position: 1.0
                        color: alertThemeActivate  ? "#FF5E00" : "#24a9b8"
                    }
                }
            }
        }

        // Applying opacity mask to shape the above gradient according to the shape of gauge image
        OpacityMask {
            anchors.fill: backgroundGlowGradinet
            source: backgroundGlowGradinet
            opacity: alertThemeActivate  ? 7.5 : 0.6
            maskSource: Image {
                id: name
                source: "qrc:/Assets/Images/Gauge.png"
            }
        }
    }

    // Black drop shadow on Gauge, to give depth feel when place on top of menu ( music and map )
    DropShadow {
        id: gaugeGlow

        anchors.fill: mainGauge
        horizontalOffset: 3
        radius: 5
        spread: 0.1
        samples: 17
        color: "black"
        source: mainGauge
        opacity: 0.35
    }

    // Gauge digits markings from 0 to maxValue value.
    PathView {
        id: digits

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: adaptive.height(-150)
        z: 1

        delegate: Text {
            id: digitsText

            text: digits.model[index]
            color: alertThemeActivate  ? "#5a2201" : "#1f344d"
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

    // Inner Black dial that shows current value in text form
    Rectangle{
        id: centeralDialoutter

        z: 3
        anchors.centerIn: parent
        width: adaptive.average(150+15)
        height: adaptive.average(150+15)
        radius: 180
        color: "black"

        Rectangle{
            anchors.fill: parent
            color: "#24a9b8"
            radius: parent.radius
            opacity: 0.4

            ColorAnimation on color { to: "#E30B5C"; duration: 1000 ;running: alertThemeActivate }
            ColorAnimation on color { to: "#24a9b8"; duration: 1000 ;running: !alertThemeActivate }
        }

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
                color: "#b5b5b5"
                font.pointSize: adaptive.average(45)
                font.family: uniTextFont.name
                anchors{
                    centerIn: parent
                    verticalCenterOffset: -5
                }
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
            opacity: alertThemeActivate  ? 0.28 : 0.65
            color: "#24a9b8"
            cornerRadius: centeralDialoutter.radius + glowRadius

            Behavior on opacity {
                NumberAnimation {
                    duration: 1000
                }
            }

            ColorAnimation on color { to: "#FF5E00"; duration: 1000 ;running: alertThemeActivate }
            ColorAnimation on color { to: "#24a9b8"; duration: 1000 ;running: !alertThemeActivate }
        }

    }

    // Needle element
    Rectangle{
        id: needleElement

        property int angle: value/maxValue * 320

        z: 2
        anchors.centerIn: parent
        radius: 180
        width: adaptive.average(163)
        height: adaptive.average(163)
        rotation: -128 +angle
        color: "#307fd5"
        border.color: "#307fd5"

        // Needle asset
        Image {
            id: needleAsset

            x: adaptive.width(-29)
            y: adaptive.height(-77)
            width: adaptive.average(86)
            height: adaptive.average(98)
            source: "qrc:/Assets/Images/needle.png"

            LinearGradient {
                visible: alertThemeActivate
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, 150)
                source: needleAsset
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "black" }
                    GradientStop { position: 1.0; color: "#FF5E00" }
                }
            }
        }
    }

    // Add griding value from 0 to maxValue
    Component.onCompleted:{
        var step = maxValue/8
        const newModel = [4,5,6,7,8,0,1,2,3];

        for (let i = 0 ; i <= 8; i++) {
            newModel[i] = newModel[i] * step
        }

        digits.model = newModel
    }
}
