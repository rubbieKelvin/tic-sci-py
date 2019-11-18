import QtQuick 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.0
import "src/qml"
import "src/js/app.js" as Js
import "src/js/QChart.js" as Charts

ApplicationWindow{
	id: root
	width: 800
	height: 425
	visible: true
	minimumWidth: 780
	minimumHeight: 425

	property int rounds: 0
	signal nextPlayer(string player)

	function emit_next(player_id) {
	    nextPlayer(player_id);
	}

	Connections {
	    target: root
	    onNextPlayer:{
			play_space.mark_text = Js.current;
			console.log("next: "+player);
			if (player == Js.player.ai){
				ai_pick_timer.start()
			}
		}
	}

	Timer{
		id: ai_pick_timer
		interval: 800
		onRunningChanged:{
			if(running){
				load_bar.visible = true;
			}
		}
		onTriggered:{
			Js.ai_pick();
			load_bar.visible = false;
		}
	}

	Rectangle{
		id: rectangle
		color: "#ffffff"
		anchors.fill: parent

		Label {
			y: 8
			width: 74
			height: 40
			text: qsTr("tic-sci-py")
			anchors.left: parent.left
			anchors.leftMargin: 23
			font.weight: Font.Medium
			font.pointSize: 12
			font.family: "Montserrat"
			verticalAlignment: Text.AlignVCenter
		}

		Label {
			id: reset_label
			y: 8
			width: 99
			height: 40
			color: "#de595959"
			text: qsTr(" - reseting...")
			anchors.left: parent.left
			anchors.leftMargin: 97
			font.family: "Montserrat"
			verticalAlignment: Text.AlignVCenter
			visible: false
		}

		ProgressBar {
			id: load_bar
			y: 421
			indeterminate: true
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 0
			anchors.right: parent.right
			anchors.rightMargin: 0
			anchors.left: parent.left
			anchors.leftMargin: 0
			value: 0.5
			visible: false
			enabled: visible
		}


		RowLayout {
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 22
			anchors.right: parent.right
			anchors.rightMargin: 21
			anchors.left: parent.left
			anchors.leftMargin: 18
			anchors.top: parent.top
			anchors.topMargin: 58

			PlaySpace {
				id: play_space
				Layout.preferredHeight: 325
				Layout.preferredWidth: 325
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				mark_text: Js.current
				mark_color: (mark_text==="O")?"#007bff":"#28a745"

				onClick: {
					Js.human_pick(number);
				}

				onResetStarted:{
					reset_label.visible = true;
					rounds += 1;
				}

				onResetEnded:{
					reset_label.visible = false;
					// Js.next_player();
				}
			}

			QChart {
				id: chart_line;
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				Layout.preferredHeight: 325
				Layout.preferredWidth: 431
				chartAnimated: false;
				chartData: Js.ChartLineData;
				chartType: Charts.ChartType.LINE;
			}
		}


		RowLayout {
			x: 388
			y: 8
			anchors.right: parent.right
			anchors.rightMargin: 29

			ScoreBar {
				color: "#dc3545"
				Layout.preferredHeight: 40
				Layout.preferredWidth: 137
				play_role: "rounds"
				score: rounds
			}

			ScoreBar {
				color: "#28a745"
				play_role: "O"
			}

			ScoreBar {
				color: "#007bff"
				play_role: "X"
			}
		}

	}
}





































/*##^## Designer {
    D{i:2;anchors_x:188}D{i:3;anchors_x:97}D{i:5;anchors_x:18;anchors_y:78}D{i:11;anchors_x:0}
D{i:1;anchors_x:23}
}
 ##^##*/
