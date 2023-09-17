import QtQuick 2.0
import QtLocation 5.6
import QtQml 2.3
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtPositioning 5.6
import QtQuick.Controls.Styles 1.4

Page {
    width:  adaptive.width(500)
    height: adaptive.height(300)
//    color: "transparent"

    property var currentLoc: QtPositioning.coordinate(48.150492, 11.537279)   //QtPositioning.coordinate(-27.573383, 153.091167)
    property bool isRoutingStart: false


    function startAnimation (){
        geoModel.update()
    }

    RadialGradient {
        z: 100000000
          anchors.fill: parent
          gradient: Gradient {
              GradientStop {
                position: 0.0
                color: "#00000000"
              }
              GradientStop {
                position: 0.52
                color: "black"
              }
            }

      }

    // Main map
    Map {
        id: map

        anchors.fill: parent
        copyrightsVisible: false
        center: QtPositioning.coordinate(48.1546944, 11.5373611)
        zoomLevel: 13.3
        bearing: -80

        plugin: Plugin {
            name: "mapboxgl"

            PluginParameter { name: "mapboxgl.access_token"; value: "pk.eyJ1IjoiaGFzZWVidGFyaXExOTk4IiwiYSI6ImNsbGw4cXQ3YTFsdXkzanBxaG1rZDZrYTgifQ.8M9sbj-GM8oDrhAfCMUasw"}
            PluginParameter { name: "mapboxgl.mapping.additional_style_urls"; value: "mapbox://styles/haseebtariq1998/clm1o9olf00rf01qxb3nr9n82"}

        }


        // Route line
        MapItemView{
            id: mapRouteLine

            model: routeModel
            delegate: Component {
                MapRoute{
                    route: routeData
                    line.color: "aqua"
                    line.width: 7

                }
            }
        }

        // Current location marker
        MapQuickItem{
            id: currentLocationMarker
            coordinate: QtPositioning.coordinate(48.150492, 11.537279)
            visible: false
            z:1000

            onCoordinateChanged:
            {
                if(isRoutingStart)
                     map.center = coordinate
            }

            sourceItem: Rectangle{
                width: adaptive.width(100) * (map.zoomLevel / 17)
                height: adaptive.height(100) *  (map.zoomLevel / 17)
                color: "transparent"
                anchors.centerIn: parent
                radius: 180

                Image {
                    id: car
                    width: adaptive.width(100) * (map.zoomLevel / 17)
                    height: adaptive.height(100) *  (map.zoomLevel / 17)
                    source: "qrc:/Assets/Images/Map/CarMarker.png"
                    anchors.centerIn: parent
//                    anchors.horizontalCenterOffset: 3
                }
            }

            Behavior on coordinate {
                PropertyAnimation {

                    duration: 5000
                }
            }
        }


        // Destination marker
        MapQuickItem{
            id: destinationMarker
            visible: false
            z:1000


            sourceItem: Rectangle{
                width: adaptive.width(50) * (map.zoomLevel / 17)
                height: adaptive.height(50) *  (map.zoomLevel / 17)
                color: "transparent"
                anchors.centerIn: parent
                radius: 180

                Image {
                    width: adaptive.width(50) * (map.zoomLevel / 17)
                    height: adaptive.height(50) *  (map.zoomLevel / 17)
                    source: "qrc:/Assets/Images/Map/LocationMarker.png"
                    anchors.centerIn: parent
                }
            }
        }

        // Departure location marker
        MapQuickItem{
            id: startMarker
            visible: false
            z:1000


            sourceItem: Rectangle{
                width: adaptive.width(50) * (map.zoomLevel / 17)
                height: adaptive.height(50) *  (map.zoomLevel / 17)
                color: "transparent"
                anchors.centerIn: parent
                radius: 180

                Image {
                    width: adaptive.width(50) * (map.zoomLevel / 17)
                    height: adaptive.height(50) *  (map.zoomLevel / 17)
                    source: "qrc:/Assets/Images/Map/LocationMarker.png"
                    anchors.centerIn: parent
                }
            }
        }



        // Route model to calculate route
        RouteModel{
            id : routeModel
            plugin: geoModel.plugin
            query: RouteQuery{
                id:  routeQuery
            }


            onRoutesChanged: {

                map.center = routeModel.get(0).path[ (routeModel.get(0).path.length/2).toFixed(0) ]
                console.log(map.center)
                destinationMarker.coordinate = routeModel.get(0).path[ routeModel.get(0).path.length -1 ]
                startMarker.coordinate = currentLoc
                destinationMarker.visible = true
                startMarker.visible = true
                animationTimer.running = true
            }
        }


        Timer{
            id: animationTimer

            interval: 3000
            onTriggered: {
                startMarker.visible = false
                currentLocationMarker.visible = true
                isRoutingStart = true
                simulateDrive.path = routeModel.get(0).path

                routeStartAnimation.running = true
                simulateDrive.running = true
            }
        }

        // To simulate car driving on route
        Timer{
            id: simulateDrive

            property var path
            property int index

            interval: 1000
            repeat: true
            onTriggered: {
                if(path.length > index)
                {
                currentLocationMarker.coordinate = path[index]
                index++
                }
                else{
                    simulateDrive.stop()
                }

            }
        }

        // To find coordinate of destination location
        GeocodeModel{
            id: geoModel

            plugin: Plugin
            {
                name: "osm"
                PluginParameter {
                    name: "osm.mapping.custom.host"
                    value: "https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png"
                }
            }
            query: "MEININGER Hotel München Olympiapark, Landshuter Allee 174, 80637 München, Germany"

            onLocationsChanged: {
                if(count)
                {
                    routeQuery.addWaypoint(currentLoc)
                    routeQuery.addWaypoint(get(0).coordinate)
                    routeModel.update()
                }
            }
        }
    }


    SequentialAnimation{
      id: routeStartAnimation

      PropertyAnimation {
          id: centeranimation

          duration: 1000
          target: map
          property: "center"
          to: currentLoc
      }
        NumberAnimation{
            id: zoomAnimation

            target: map
            duration: 6000
            properties: "zoomLevel"
            from: map.zoomLevel
            to: 18
        }

        NumberAnimation{
            id: tiltAnimation

            target: map
            duration: 1000
            properties: "tilt"
            from: 0
            to: map.maximumTilt
        }

        NumberAnimation{
            id: rotationAnimation

            target: map
            duration: 5000
            properties: "bearing"
            from: -80
            to: 0
        }


    }

    Component.onCompleted: {


    }
}
