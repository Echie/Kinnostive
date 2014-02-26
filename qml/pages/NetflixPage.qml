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
        anchors.fill: parent
        spacing: Theme.paddingLarge

        model: netflixList

        delegate: ListItem {
            onClicked: {
                pageStack.push(Qt.resolvedUrl("NetflixSinglePage.qml"),
                               {message: model.title})
            }
            Row {
                Column {
                    Label {
                        text: model.title
                    }
                }
            }
        }
    }

}
