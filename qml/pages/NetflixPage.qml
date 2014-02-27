import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0

Page {
    XmlListModel {
        id: netflixList
        source: "http://dvd.netflix.com/NewReleasesRSS"
        query: "/rss/channel/item"

        XmlRole {
            name: "title"
            query: "title/string()"
        }
    }

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
                text: "Bluray"
                onClicked: {
                    pageStack.clear()
                    pageStack.push(Qt.resolvedUrl("MenuPage.qml"))
                    pageStack.push(Qt.resolvedUrl("BluRayPage.qml"))
                    console.log("Clicked pulldown Bluray")
                }
            }
        }

        model: netflixList
        anchors.fill: parent
        header: PageHeader { title: "Netflix releases" }

        delegate: ListItem {
            onClicked: {
                pageStack.push(Qt.resolvedUrl("NetflixSinglePage.qml"),
                               {message: model.title})
            }

            Label {
                x: Theme.paddingLarge
                text: model.title
                anchors.verticalCenter: parent.verticalCenter
                font { pixelSize: Theme.fontSizeLarge }
            }
        }
    }
}
