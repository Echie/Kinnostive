

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0


Page {

    property string areaID: ""
    property string eventID: ""

    id: finnkinoSinglePage
    //Component.onCompleted: singleEvents.printMessageInsideSingle()

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

    ListModel{id: parsedEvents}

    XmlListModel {
        id: eventData
        source:'http://www.finnkino.fi/xml/Events/?includeVideos=false&eventID='+eventID
        query: "/Events/Event"
        namespaceDeclarations: "declare namespace Events = 'http://www.w3.org/2001/XMLSchema';"
        XmlRole {
            name: "Title"
            query: "Title/string()"
        }
        function printMessageInsideSingle() {
            console.log()
        }
    }

    // DUS NUT WURK
    Column {

        Label {
            text: eventData.get(0).Title
            x: Theme.paddingLarge
            anchors.verticalCenter: parent.verticalCenter
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

        header: PageHeader { title: "Film" }
        id: eventListView
        anchors.fill: parent
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

    SilicaListView {

        id: scheduleListView
        anchors.fill: parent
        spacing: Theme.paddingLarge
        model: eventData


        delegate: ListItem {

            Label {
                text: model.Title
            }
        }
    }
}

