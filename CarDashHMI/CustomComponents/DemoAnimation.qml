import QtQuick 2.0

Item {
    id: demoAnimationMain

    property bool runAnimation: false

    SequentialAnimation{
        loops: Animation.Infinite
        running: runAnimation

        NumberAnimation{
            duration: 17000
            properties: "value"
            from: 0
            to: 7
            target: rpmGauge
            easing.type:Easing.OutInQuad // Easing.OutInSine // Easing.InOutSine
        }

        NumberAnimation{
            duration: 10000
            properties: "value"
            to: 0
            target: rpmGauge
        }
    }

    SequentialAnimation{
        loops: Animation.Infinite
        running: runAnimation

        NumberAnimation{
            duration: 17000
            properties: "value"
            from: 0
            to: 210
            target: speedGauge

            easing.type:Easing.InOutQuad

        }

        NumberAnimation{
            duration: 10000
            properties: "value"
            to: 0
            target: speedGauge


        }
    }

    SequentialAnimation{

        running: runAnimation
        loops: Animation.Infinite

        NumberAnimation{
            duration: 6000
            properties: "value"
            from: 0
            to: 100
            target: fuelBar
        }
        NumberAnimation{
            duration: 6000
            properties: "value"
            from: 100
            to: 0
            target: fuelBar
        }
    }
}
