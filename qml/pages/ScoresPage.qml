import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"
import "../game.js" as Game
import "../difficulties.js" as Difficulties
import "../gamemodes.js" as Gamemodes
import "../scoresdb.js" as ScoresDB


Page {
    id: page

    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentWidth: col.width
        contentHeight: col.height + col.y

        GamePageHeader {
            id: header
            text: qsTr("Highscores")
        }



        FontLoader { id: gameMenuFont; source: "../fonts/peleja-regular-1.0.otf" }

        Column {
            width: page.width
            id: col
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingSmall

            anchors.top: header.bottom
            anchors.topMargin: Theme.paddingLarge

            Component.onCompleted: getScores()

            function getScores() {
                for (var j = 0; j < Gamemodes.gamemodes.length; j++) {

                    Qt.createQmlObject(
                                'import QtQuick 2.0; import Sailfish.Silica 1.0; Label {font.pixelSize: Theme.fontSizeLarge;font.family: gameMenuFont.name; color: Theme.highlightColor;text:"'
                                + Game.gamemodes[j].name + '"}',
                                col, "dynamicSnippet")

                    var scores = ""

                    for (var i = Difficulties.difficulties.length - 1; i >= 0; i--) {
                        var score = ScoresDB.getHighScoreList(Game.gamemodes[j].id, i)
                        if (score !== "")
                            scores = scores + Difficulties.difficulties[i].name + ':\n' + score + '\n'
                    }

                    Qt.createQmlObject(
                                'import QtQuick 2.0; import Sailfish.Silica 1.0; Label {font.pixelSize: Theme.fontSizeSmall;font.family: gameMenuFont.name;color: Theme.secondaryHighlightColor; text:"' + scores + '";}',
                                col, "dynamicSnippet")
                }
                return scores
            }
        }
        VerticalScrollDecorator {
            flickable: flickable
        }
    }
}