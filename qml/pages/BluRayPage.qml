import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0

Page {
    id: searchPage
    property string searchString
    property bool keepSearchFieldFocus


    Component.onCompleted: parse()

    ListModel {
        id: bluray
    }

    SilicaListView {
        anchors.fill: parent
        spacing: Theme.paddingLarge
        model: bluray
        delegate: ListItem {
            Row {


                Column {
                    Label {
                        text: model.Title
                    }
                }
            }
        }
    }

    //http://qt-project.org/forums/viewthread/5743
    function parse() {
       bluray.clear();
        var xhr = new XMLHttpRequest();
        xhr.open('GET','http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?apikey=93u36yvaapta4kaur425e8nq&page_limit=2',true);
        xhr.onreadystatechange = function() {
            if ( xhr.readyState == xhr.DONE) {
                if ( xhr.status == 200) {

                    var jsonObject = JSON.parse(xhr.responseText);
                    loaded(jsonObject);
                }
            }
        }
        xhr.send();
    }

    function loaded(jsonObject){
        for ( var index in jsonObject.movies ){
            bluray.append({ 'Title' : jsonObject.movies[index].title});
         }


    }
}
