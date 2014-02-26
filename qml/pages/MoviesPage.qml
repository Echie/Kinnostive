

/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
** Contact: Joona Petrell <joona.petrell@jollamobile.com>
** All rights reserved.
**
** This file is part of Sailfish Silica UI component package.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the Jolla Ltd nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0


Page {

    id: moviePage

    PageHeader {
        title:"Choose a movie"
    }

    property string searchString
    property string message: ""

    onSearchStringChanged: updateFilmList()

    XmlListModel {
        id: events
        source: 'http://www.finnkino.fi/xml/Events/?area='+message
        query: "/Events/Event"
        namespaceDeclarations: "declare namespace Events = 'http://www.w3.org/2001/XMLSchema';"
        XmlRole {
            name: "ID"
            query: "ID/string()"
        }
        XmlRole {
            name: "Title"
            query: "Title/string()"
        }
        XmlRole {
            name: "RatingImageUrl"
            query: "RatingImageUrl/string()"
        }

        onStatusChanged: {

            if (status === XmlListModel.Ready) {
               // console.log("inside MoviesPage:")
               // console.log(message)

                for(var index = 0; index < count;index++) {
                    var newTitle = get(index).Title;
                    var newID = get(index).ID;

                    allFilmsModel.append({"title":newTitle,"id":newID});

                }
                updateFilmList()
            }
        }
    }

    // Contains all movies
    ListModel { id:allFilmsModel }

    // Contains filtered movies to be shown on screen
    ListModel { id: filmListModel }

    function updateFilmList() {
        filmListModel.clear()

        for(var index = 0; index < allFilmsModel.count; index++) {

            var newTitle = allFilmsModel.get(index).title
            var newID = allFilmsModel.get(index).id

            if (newTitle.toLowerCase().indexOf(searchString)  !== -1  ) {
                filmListModel.append({"title":newTitle,"id":newID})
            }
        }

        /* DEBUG
        for (var ind = 0; ind <filmListModel.count; ind++) {
            console.log(filmListModel.get(ind).title,filmListModel.get(ind).id)
        }*/
    }

    Column {
        id: headerContainer

        width: cityPage.width
        anchors.rightMargin: 50

//        PageHeader {
//            title:"Choose a movie"
//        }
    }

    SearchField {
        id: searchField
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 60

        Binding {
            target: moviePage
            property: "searchString"
            value: searchField.text.toLowerCase().trim()
        }
    }

    SilicaListView {
        //anchors.fill: parent
        anchors.topMargin: 30
        anchors.leftMargin: -50
        anchors.top: searchField.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: Theme.paddingLarge
        model: filmListModel
        header:  Item {
            id: header
            width: headerContainer.width
            height: headerContainer.height
            Component.onCompleted: headerContainer.parent = header
        }

        delegate: BackgroundItem {
            id:backgroundItem

            onClicked: {
                pageStack.push(Qt.resolvedUrl("FinnkinoSinglePage.qml"),
                               {areaID:message, eventID:model.id})
            }

            ListView.onAdd: AddAnimation {
                target: backgroundItem
            }
            ListView.onRemove: RemoveAnimation {
                target: backgroundItem
            }

            Label {
                x: searchField.textLeftMargin
                anchors.verticalCenter: parent.verticalCenter
                color: searchString.length > 0 ? (highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor)
                                               : (highlighted ? Theme.highlightColor : Theme.primaryColor)
                textFormat: Text.StyledText
                text: Theme.highlightText(model.title, searchString, Theme.highlightColor)
            }
        }
        VerticalScrollDecorator {}
    }
}
