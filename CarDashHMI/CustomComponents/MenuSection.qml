import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQml 2.12
import "qrc:/CustomComponents/Pages"

Rectangle{
    anchors.centerIn: parent
    width:  adaptive.width(500)
    height: adaptive.height(300)
    color: "red"
    visible: true

    StackView{
        id: mainApplicationStackView
        anchors.fill: parent

    }

    RadialGradient {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "#00000000"
            }
            GradientStop {
                position:0.52
                color: "#FF000000"
            }
        }

    }

    PageMap{
        id: pageMap
        visible: false
    }

    Component.onCompleted: {
        mainApplicationStackView.push(pageMap)

    }


}
