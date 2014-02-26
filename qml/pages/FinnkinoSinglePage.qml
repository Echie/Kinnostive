

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
                console.log("inside FinnkinoSinglePage")
                console.log(get(0).Title)
            }
        }
    }
    SilicaListView {

        PullDownMenu {
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

        id: ourListView
        anchors.fill: parent
        spacing: Theme.paddingLarge
        model: singleEvents

        header: PageHeader {
            title: "Film"
        }

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

