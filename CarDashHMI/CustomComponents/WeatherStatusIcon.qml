// ******************************************
// ** Weather Icon Component               **
// ******************************************
//
// Author: Haseeb Tariq
// Date: August 31, 2023
//
// The Weather Icon component is a user interface element that displays weather icons
// corresponding to different weather states. It provides visual cues for weather conditions.
//
//
// Licensing:
// This Weather Icon component is open-source and available under the GNU General Public License (GPL).
//
// ******************************************

import QtQuick 2.12
import QtQuick.Controls 2.12
import weather.enum 1.0

Item {
    id: weatherIcon

    width: adaptive.width(30)
    height: width

    Image {
        id: iconImage

        width: adaptive.width(30)
        anchors.centerIn: parent
        height: width
    }

    transitions: Transition {
        ParallelAnimation {
            NumberAnimation { properties: "opacity"; duration: 250 }
        }
    }

    states: [
        State {
            name: "Clear" ; when: weather.weatherState === WEATHER.Clear
            PropertyChanges { target: iconImage; source: "qrc:/Assets/Images/WeatherStatusIconAssets/Clear.png" }
        },
        State {
            name: "Clouds" ; when: weather.weatherState === WEATHER.Clouds
            PropertyChanges { target: iconImage; source: "qrc:/Assets/Images/WeatherStatusIconAssets/Cloud.png" }
        },
        State {
            name: "Rain" ; when: weather.weatherState === WEATHER.Rain
            PropertyChanges { target: iconImage; source: "qrc:/Assets/Images/WeatherStatusIconAssets/Rain.png" }
        },
        State {
            name: "Mist" ; when: weather.weatherState === WEATHER.Mist
            PropertyChanges { target: iconImage; source: "qrc:/Assets/Images/WeatherStatusIconAssets/Mist.png" }
        },
        State {
            name: "Snow" ; when: weather.weatherState === WEATHER.Snow
            PropertyChanges { target: iconImage; source: "qrc:/Assets/Images/WeatherStatusIconAssets/Snow.png" }
        },
        State {
            name: "Storm" ; when: weather.weatherState === WEATHER.Thunderstorm
            PropertyChanges { target: iconImage; source: "qrc:/Assets/Images/WeatherStatusIconAssets/Storm.png" }
        },
        State {
            name: "Error" ; when: weather.weatherState === WEATHER.Unknown
            PropertyChanges { target: iconImage; source: "qrc:/Assets/Images/WeatherStatusIconAssets/ErrorState.png" }
        }
    ]
}

