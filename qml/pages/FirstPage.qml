/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    property string result
    onResultChanged: updateState(page.result)

    function updateState(result) {
        if (result == "unflipped") {
            return;
        }

        // hard-set angle if necessary when flipping was done from cover
        if (result == "heads" && (rot.angle / 180) % 2 != 0) {
            rot.angle = 0;
        }
        if (result == "tails" && (rot.angle / 180) % 2 == 0) {
            rot.angle = 180;
        }

        // update text
        theResult.text = qsTr("Rolling..");
        timer.start();
    }

    // used to do stuff AFTER an animation cycle
    Timer {
        id: timer
        interval: 1500
        running: false
        repeat: false
        onTriggered: theResult.text = qsTr("You rolled ") + app.resultUserString(page.result)
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("FLIP!")
                onClicked:  {
                    var coinImageState = app.result == "unflipped" ? "heads" : app.result;
                    app.result = "tmp"; // force-trigger change handlers
                    app.result = (Math.random() * 2 > 1 ? "heads" : "tails");
                    rot.angle += (app.result == coinImageState ? 1800 : 1980);
                }
            }
        }

        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Flip a Coin")
            }
            Flipable {
                width: page.width
                height: coinimg.height
                front: Image {
                    id: coinimg
                    width: page.width - 20
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    source: "../img/heads.png"
                }
                back: Image {
                    id: coinimg2
                    width: page.width - 20
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    source: "../img/tails.png"
                }
                transform: Rotation {
                    id: rot
                    origin.x: page.width / 2
                    axis.x: 0
                    axis.y: 1
                    axis.z: 0
                    angle: 0

                    Behavior on angle { PropertyAnimation{ duration: 1500 } }
                }
            }

            Label {
                id: theResult
                width: page.width
                text: qsTr("Use the pulley menu to flip!")
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                width: page.width
                text: qsTr("CoinFlip 1.0\nby Lim Yuen Hoe (Jason moofang)") + "\n" + "github.com/jasonmoofang/CoinFlip"
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeSmall
            }
        }
    }
}


