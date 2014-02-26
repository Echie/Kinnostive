

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0


Page {

    property string message: ""

    id: netflixSinglePage

    XmlListModel {
        id: singleEvents
        source: "http://www.omdbapi.com/?t=" + message + "&r=XML"
        query: "/root/movie"
        XmlRole {
            name: "title"
            query: "@title/string()"
        }
        XmlRole {
            name: "runtime"
            query: "@runtime/string()"
        }
        XmlRole {
            name: "plot"
            query: "@plot/string()"
        }
        XmlRole {
            name: "poster"
            query: "@poster/string()"
        }
        XmlRole {
            name: "imdbRating"
            query: "@imdbRating/string()"
        }
    }

    //    onStatusChanged: {

    //        if (status === XmlListModel.Ready) {
    //            console.log("inside onStatusChanged")
    //            console.log(get(0).Title)
    //        }
    //    }

    SilicaListView {

        PullDownMenu {
            MenuItem {
                text: "Finnkino"
                onClicked: {
                    pageStack.clear()
                    pageStack.push(Qt.resolvedUrl("MenuPage.qml"))
                    pageStack.push(Qt.resolvedUrl("FinnkinoPage.qml"))
                    console.log("Clicked pulldown Finnkino")
                }
            }
            MenuItem {
                text: "Netflix"
                onClicked: {
                    pageStack.clear()
                    pageStack.push(Qt.resolvedUrl("MenuPage.qml"))
                    pageStack.push(Qt.resolvedUrl("NetflixPage.qml"))
                    console.log("Clicked pulldown Netflix")
                }
            }
            MenuItem {
                text: "Bluray"
                onClicked: {
                    pageStack.clear()
                    pageStack.push(Qt.resolvedUrl("MenuPage.qml"))
                    pageStack.push(Qt.resolvedUrl("BluRayPage.qml"))
                    console.log("Clicked pulldown Bluray")
                }
            }
        }

        anchors.fill: parent
        spacing: Theme.paddingLarge
        model: singleEvents

        delegate: ListItem {

            Row {

                Column {
                    Label {
                        text: model.title
                    }
                    Label {
                        text: model.imdbRating
                    }
                    Label {
                        text: model.runtime
                    }
                    Image {
                        height: Theme.itemSizeLarge
                        width: Theme.itemSizeLarge
                        source: model.poster
                    }
                    Label {
                        text: model.plot
                    }
                }
            }
        }
    }
}

