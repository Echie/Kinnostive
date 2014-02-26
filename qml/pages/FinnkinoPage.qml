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

Page {
    id: cityPage

    ListModel {
        id: allCityModel

        ListElement {
            Name: "Espoo"
            ID: "1012"
        }
        ListElement {
            Name: "Helsinki"
            ID: "1002"
        }
        ListElement {
            Name: "Jyväskylä"
            ID: "1015"
        }
        ListElement {
            Name: "Kuopio"
            ID: "1016"
        }
        ListElement {
            Name: "Lahti"
            ID: "1017"
        }
        ListElement {
            Name: "Oulu"
            ID: "1018"
        }
        ListElement {
            Name: "Pori"
            ID: "1019"
        }
        ListElement {
            Name: "Tampere"
            ID: "1021"
        }
        ListElement {
            Name: "Turku"
            ID: "1022"
        }
        ListElement {
            Name: "Vantaa"
            ID: "1013"
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

        model: allCityModel
        anchors.fill: parent
        header: PageHeader { title: "Choose a City" }

        delegate: ListItem {
            id: backgroundItem

            onClicked: {
                pageStack.push(Qt.resolvedUrl("MoviesPage.qml"),
                               {message:model.ID})
            }

            Label {
                x: Theme.paddingLarge
                text: Name
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        VerticalScrollDecorator {}
    }
}
