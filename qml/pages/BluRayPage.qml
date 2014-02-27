import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0

Page {
    id: searchPage

    Component.onCompleted: parse()

    BusyIndicator{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        id: busyInd
        running: true
    }

    ListModel {
        id: bluray
    }

    SilicaListView {


        PullDownMenu {
            MenuItem {
                text: "Finnkino"
                onClicked: {
                    pageStack.clear()
                    pageStack.push(Qt.resolvedUrl("MenuPage.qml"))
                    pageStack.push(Qt.resolvedUrl("FinnkinoPage.qml"))
                }
            }
            MenuItem {
                text: "Netflix"
                onClicked: {
                    pageStack.clear()
                    pageStack.push(Qt.resolvedUrl("MenuPage.qml"))
                    pageStack.push(Qt.resolvedUrl("NetflixPage.qml"))
                }
            }
        }

        header: PageHeader { title: "Bluray releases" }
        anchors.fill: parent
        model: bluray

        delegate: ListItem {
            onClicked: {
                pageStack.push(Qt.resolvedUrl("NetflixSinglePage.qml"),
                               {message: model.Title})
            }
            Label {
                x: Theme.paddingLarge
                text: model.Title
                anchors.verticalCenter: parent.verticalCenter
                font { pixelSize: Theme.fontSizeLarge }
                width: parent.width - 75
                wrapMode: Text.WordWrap
            }
        }
    }

    //http://qt-project.org/forums/viewthread/5743
    function parse() {
        bluray.clear();
        var xhr = new XMLHttpRequest();
        xhr.open('GET','http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?apikey=93u36yvaapta4kaur425e8nq&page_limit=25',true);
        xhr.onreadystatechange = function() {
            if ( xhr.readyState == xhr.DONE) {
                if ( xhr.status == 200) {

                    var jsonObject = JSON.parse(xhr.responseText);
                    loaded(jsonObject);
                }
            }
        }
        xhr.send();
        busyInd.running=false
    }

    function loaded(jsonObject){
        for ( var index in jsonObject.movies ){
            bluray.append({ 'Title' : jsonObject.movies[index].title});
        }


    }
}
