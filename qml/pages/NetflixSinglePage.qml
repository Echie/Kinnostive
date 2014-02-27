

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

        onStatusChanged: {

            if (status === XmlListModel.Ready) {
                var tempPoster = get(0).poster
                if(tempPoster === "N/A"){
                    tempPoster="noposter.png"
                }
                titleLabel.text = get(0).title
                ratingLabel.text = "IMDB: " + get(0).imdbRating
                runtimeLabel.text ="Runtime: " + get(0).runtime
                poster.source = tempPoster
                synopsisLabel.text = get(0).plot

            }
        }
    }


    SilicaFlickable {

        anchors.fill:parent

        PullDownMenu {
            MenuItem {
                text: "Finnkino"
                onClicked: {
                    pageStack.clear()
                    pageStack.push(Qt.resolvedUrl("MenuPage.qml"))
                    pageStack.push(Qt.resolvedUrl("Finnkinopage.qml"))
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

        PageHeader {
            title: "Film"
        }

        Column {
            id:labelContainer
            spacing: 5
            width:parent.width
            anchors.top:parent.top
            anchors.topMargin: 75

            Label {
                width: parent.width
                id:titleLabel
                text: ""
                x: Theme.paddingLarge
                font { pixelSize: Theme.fontSizeExtraLarge }
                wrapMode: Text.WordWrap
                maximumLineCount: 4
                truncationMode: TruncationMode.Fade
            }

            Row {
                spacing: 2

                Image {
                    id:poster
                    height: Theme.itemSizeLarge
                    width: Theme.itemSizeLarge
                    source: ""
                }

                Column {
                    Label {
                        id:ratingLabel
                        text: ""
                        x: Theme.paddingLarge
                        font { pixelSize: Theme.fontSizeLarge }
                    }
                    Label {
                        id:runtimeLabel
                        text: ""
                        x: Theme.paddingLarge
                        font { pixelSize: Theme.fontSizeLarge }
                    }
                }
            }

            Label {
                width: parent.width
                id:synopsisLabel
                text: ""
                x: Theme.paddingSmall
                font.pixelSize: Theme.fontSizeMedium
                wrapMode: Text.WordWrap
                maximumLineCount: 20
                truncationMode: TruncationMode.Fade

            }
        }
    }


    /*
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
    */
}
