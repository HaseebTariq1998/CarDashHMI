import QtQuick 2.0

Item {
    id: mainBarIndicator

    property double value: 0
    property double maxValue: 100

    width: adaptive.width(98)
    height: adaptive.height(131)
    state: getState()

      function getState() {
          var percent = (value / maxValue) * 100

          if (percent >= 100) return "fourBar"
          else if (percent >= 75) return "threeBar"
          else if (percent >= 50) return "twoBar"
          else if (percent >= 25) return "oneBar"
          else return "zeroBar"
      }

    Image{
        id: barOne
        source:"qrc:/Assets/Images/BarIndicator/barIndicatorOne.png"
        height: parent.height
        width: parent.width
        anchors.centerIn: parent
    }

    Image{
        id: barTwo
        source:"qrc:/Assets/Images/BarIndicator/barIndicatorTwo.png"
        height: parent.height
        width: parent.width
        anchors.centerIn: parent
    }

    Image{
        id: barThree
        source:"qrc:/Assets/Images/BarIndicator/barIndicatorThree.png"
        height: parent.height
        width: parent.width
        anchors.centerIn: parent
    }

    Image{
        id: barFour
        source: "qrc:/Assets/Images/BarIndicator/barIndicatorFour.png"
        height: parent.height
        width: parent.width
        anchors.centerIn: parent
    }

    states: [
        State {
            name: "zeroBar"
            PropertyChanges { target: barOne; opacity: 0.2}
            PropertyChanges { target: barTwo; opacity: 0.2}
            PropertyChanges { target: barThree; opacity: 0.2}
            PropertyChanges { target: barFour; opacity: 0.2}

        },
        State {
            name: "oneBar"
            PropertyChanges { target: barOne; opacity: 1}
            PropertyChanges { target: barTwo; opacity: 0.2}
            PropertyChanges { target: barThree; opacity: 0.2}
            PropertyChanges { target: barFour; opacity: 0.2}

        },
        State {
            name: "twoBar"
            PropertyChanges { target: barOne; opacity: 1}
            PropertyChanges { target: barTwo; opacity: 1}
            PropertyChanges { target: barThree; opacity: 0.2}
            PropertyChanges { target: barFour; opacity: 0.2}

        },
        State {
            name: "threeBar"
            PropertyChanges { target: barOne; opacity: 1}
            PropertyChanges { target: barTwo; opacity: 1}
            PropertyChanges { target: barThree; opacity: 1}
            PropertyChanges { target: barFour; opacity: 0.2}

        },
        State {
            name: "fourBar"
            PropertyChanges { target: barOne; opacity: 1}
            PropertyChanges { target: barTwo; opacity: 1}
            PropertyChanges { target: barThree; opacity: 1}
            PropertyChanges { target: barFour; opacity: 1}

        }
    ]
}
