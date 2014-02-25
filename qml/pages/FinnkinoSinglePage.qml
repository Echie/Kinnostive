

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0


Page {


    property string message: ""

    id: finnkinoSinglePage
    Component.onCompleted: events.printShit()

    XmlListModel {
        id: events
        source: message
        query: "/Events/Event"
        namespaceDeclarations: "declare namespace Events = 'http://www.w3.org/2001/XMLSchema';"
        XmlRole {
            name: "Title"
            query: "Title/string()"
        }/*
        XmlRole {
            name: "RatingImageUrl"
            query: "RatingImageUrl/string()"
        }*/
        function printShit() {
            console.log(message)
        }
    }

    SilicaListView {
        anchors.fill: parent
        spacing: Theme.paddingLarge
        model: events

        delegate: ListItem {
            Row {
                /*
                Image {
                    height: Theme.itemSizeLarge
                    width: Theme.itemSizeLarge
                    source: "https://media.finnkino.fi/images/rating_large_16.png"
                }*/

                Column {
                    Label {
                        text: model.Title
                    }
                }
            }
        }
    }
}

