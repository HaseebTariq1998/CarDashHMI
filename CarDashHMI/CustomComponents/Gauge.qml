import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQml 2.3

Rectangle{
    id: dial
    width: adaptive.width(391)
    height: adaptive.height(387)
    radius: 180
    color: "transparent"

    property int value: 0
    property int maxValue: 8


    DropShadow {
          anchors.fill: dial
          horizontalOffset: 3
          verticalOffset: 3
          radius: 5
          samples: 17
          color: "black"
          source: dial
          opacity: 0.3
    }

    PathView {
        id: digits
             anchors.verticalCenter: parent.verticalCenter
             anchors.horizontalCenter: parent.horizontalCenter
             anchors.verticalCenterOffset: adaptive.height(-150)
             //model: [0,1,2,3,4,5,6,7,8]//[4,5,6,7,8,0,1,2,3]
             z: 1


             delegate: Text {

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




    Image {
        source: "qrc:/Assets/Images/Gauge.png"
        height: adaptive.height(391)
        width: adaptive.width(387)
        anchors{
           centerIn: parent
        }
    }

    Rectangle{

        id: decoy
        anchors.centerIn: parent
        width: adaptive.average(150)
        height: adaptive.average(150)
        z: 3
        radius: 180
        color: "green"

        Rectangle{
            id: inner
            anchors.centerIn: parent
            width: adaptive.average(150)
            height: adaptive.average(150)
            z: 1
            radius: 180
            color: "black"

            Text {
                id: valueTitle
                text: value
                anchors.centerIn: parent
                color: "#b5b5b5"
                font.pointSize: adaptive.average(45)
                font.family: uniTextFont.name


                anchors.verticalCenterOffset: -5
            }

            Text {

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

//            Glow {
//                 anchors.fill: decoy
//    //             horizontalOffset: -10
//    //             verticalOffset: -10
//                 radius: 140//140.0
//                 samples:  1 + radius * 2
//                 color: "#24a9b8"
//                 source: decoy
//                 z:-1
//                 smooth: true
//                 cached: true
//                 opacity: 0.6
//             }

        RectangularGlow {
                id: effect
                anchors.fill: decoy
                glowRadius: 50
                spread: 0.5
                color: "#24a9b8"
                cornerRadius: decoy.radius + glowRadius
            }

    }

    Rectangle{
        id: need
        anchors.centerIn: parent
        radius: 180
        width: adaptive.average(163)
        height: adaptive.average(163)
        property int angle: value/maxValue * 320
        rotation: -128 +angle
        color: "#307fd5"
        border.color: "#307fd5"
        z: 2



        Image {
            id: needleImg
            x: -29
            y: -77
            width: adaptive.average(86)
            height: adaptive.average(98)

            source: "qrc:/Assets/Images/needle.png"

            Component.onCompleted: {
                console.log("---------------------------",needleImg.width,needleImg.height)
            }
        }



//        NumberAnimation {
//            target: need
//            properties: "angle"
//            from: 0
//            to: 320
//            duration: 15000
//            running: true



//        }




    }

    Component.onCompleted:{

        var step = maxValue/8

        console.log(step)

        const newModel = [4,5,6,7,8,0,1,2,3];

          for (let i = 0 ; i <= 8; i++) {
              newModel[i] = newModel[i] * step
              console.log(newModel[i])
          }

          console.log(newModel)

          digits.model = newModel
    }

}
