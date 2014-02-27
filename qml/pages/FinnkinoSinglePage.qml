

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0

Page {
    property string areaID: ""
    property string eventID: ""

    id: finnkinoSinglePage

    XmlListModel {
        id: allshows
        source:'http://www.finnkino.fi/xml/Schedule/?area='+areaID+'&eventID='+eventID+'&nrOfDays=3'

        query: "/Schedule/Shows/Show"
        namespaceDeclarations: "declare namespace Events = 'http://www.w3.org/2001/XMLSchema';"
        XmlRole {
            name: "Showstart"
            query: "dttmShowStart/string()"
        }

        XmlRole {
            name: "Theatre"
            query: "Theatre/string()"
        }

        onStatusChanged: {

            if (status === XmlListModel.Ready) {

                for(var index = 0; index < count;index++) {
                    var newShowstart = get(index).Showstart;
                    var newTheatre = get(index).Theatre;

                    //TIME PARSE
                    var tArray = newShowstart.split('T');
                    //YEAR-MN-DA
                    var dateArray = tArray[0].split('-');
                    var clockString= tArray[1].slice(0,tArray[1].length-3);
                    var timeString= dateArray[2]+'.'+dateArray[1]+'.'+dateArray[0]+'    '+clockString;

                    var theatreArray = newTheatre.split(',');

                    parsedEvents.append({"Showstart":timeString,"Theatre":theatreArray[0]});

                }

                if(parsedEvents.count===0){

                    parsedEvents.append({"Showstart":'No showings',"Theatre":''});

                }
            }
        }
    }

    XmlListModel {
        id: eventData
        source:'http://www.finnkino.fi/xml/Events/?includeVideos=false&eventID='+eventID
        query: "/Events/Event"
        namespaceDeclarations: "declare namespace Events = 'http://www.w3.org/2001/XMLSchema';"
        XmlRole {
            name: "Title"
            query: "Title/string()"
        }
        XmlRole {
            name: "Synopsis"
            query: "ShortSynopsis/string()"
        }
        XmlRole {
            name: "Poster"
            query: "Images/EventMicroImagePortrait/string()"
        }

        onStatusChanged: {

            // Kiitos Ramsu
            if (status === XmlListModel.Ready) {
                filmLabel.text = get(0).Title
                synopsisLabel.text = get(0).Synopsis
                moviePoster.source = get(0).Poster
            }
        }
    }

    ListModel{id: parsedEvents}

    SilicaFlickable {

        anchors.fill:parent
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

        PageHeader {
            title: "Film"
        }

        Column {
            id:labelContainer
            spacing:3
            width:parent.width
            anchors.top: parent.top
            anchors.topMargin: 75
            Image {
                id:moviePoster
                height: Theme.itemSizeLarge
                width: Theme.itemSizeLarge
                source: ""
            }
            Label {
                width: parent.width
                id:filmLabel
                text: ""
                x: Theme.paddingLarge
            }

            Label {
                width: parent.width
                id:synopsisLabel
                text: ""
                x: Theme.paddingLarge
                font.pixelSize: Theme.fontSizeExtraSmall
                wrapMode: Text.WordWrap
                maximumLineCount: 3
                truncationMode: TruncationMode.Fade

            }
        }

        SilicaListView {

            anchors.topMargin: 70
            anchors.top: labelContainer.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            id: eventListView
            model: parsedEvents
            VerticalScrollDecorator {}

            delegate: ListItem {

                Label {
                    x: Theme.paddingLarge
                    text: model.Showstart+'          '+model.Theatre
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
