

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

    id: page
    PageHeader { title: "Main Menu" }
    /*
    PageHeader { title: "Main Menu" }

    Column {
        anchors.fill: parent
        anchors.topMargin: 75

        Row {
            Image {
                id:finnkinoImage
                height: Theme.itemSizeLarge
                width: Theme.itemSizeLarge
                source: "Finnkino_icon.png"
            }
            Label {
                text: "Finnkino"
                x: Theme.paddingLarge
            }
        }

        Row {
            Image {
                id:netflixImage
                height: Theme.itemSizeLarge
                width: Theme.itemSizeLarge
                source: "Netflix_Icon.png"
            }
            Label {
                text: "Netflix"
                x: Theme.paddingLarge

            }
        }

        Row {
            Image {
                id:blurayImage
                height: Theme.itemSizeLarge
                width: Theme.itemSizeLarge
                source: "BluRay_Icon.png"
            }
            Label {
                text: "Bluray"
                x: Theme.paddingLarge
            }
        }
    }
}

*/

    SilicaListView {

        id: ourlistView
        anchors.fill: parent
        anchors.leftMargin: 100
        anchors.topMargin: 200
        spacing: 100
        model: ListModel {
            ListElement {
                path: "Finnkino_icon.png"
                name: "Finnkino"
            }
            ListElement {
                path: "Netflix_Icon.png"
                name: "Netflix"
            }
            ListElement {
                path: "BluRay_Icon.png"
                name: "BluRay"
            }

        }

        delegate: ListItem {
            id: defaultListItem
            onClicked: {
                pageStack.push(Qt.resolvedUrl(name + "Page.qml"))
            }

            Row {
                spacing: 20
                Image {
                    height: Theme.itemSizeLarge
                    width: Theme.itemSizeLarge
                    source: path

                }
                Label {
                    x: Theme.paddingLarge
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    font { pixelSize: Theme.fontSizeExtraLarge }

                }
            }
        }
    }
}
