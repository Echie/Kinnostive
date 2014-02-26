

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0


Page {

    property string message: ""

    id: finnkinoSinglePage
    Component.onCompleted: singleEvents.printMessageInsideSingle()

    XmlListModel {
        id: singleEvents
        source: message
        query: "/Events/Event"
        namespaceDeclarations: "declare namespace Events = 'http://www.w3.org/2001/XMLSchema';"
        XmlRole {
            name: "Title"
            query: "Title/string()"
        }
        function printMessageInsideSingle() {
            console.log(message)
        }

        onStatusChanged: {

            if (status === XmlListModel.Ready) {
                console.log("inside onStatusChanged")
                console.log(get(0).Title)
            }
        }
    }
    SilicaListView {

        anchors.fill: parent
        spacing: Theme.paddingLarge
        model: singleEvents

        delegate: ListItem {

            onClicked: {
                console.log(model.Title)
            }

            Row {

                Column {
                    Label {
                        text: model.Title
                    }
                }
            }
        }
    }
}

