import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.0
import 'src/qml'
import 'src/js/app.js' as Js

ApplicationWindow{
	id: root
	width: 400
	height: 400
	title: qsTr('Tic-Tac-Toe')
	visible: true

	signal numberChosen(int number, bool toe)
	signal playerWon(int player_id)
	property int score1: 0
	property int score2: 0

	// once the app window is created...
	Component.onCompleted: {
		Game.numberChosen.connect(numberChosen);
		Game.playerWon.connect(playerWon);
	}

	// stack layout
	StackLayout {
		id: main
		currentIndex: 1
		anchors.fill: parent

		Page {
			id: intro
			width: parent.width
			height: parent.height
			enabled: (main.currentIndex == 0)

			Rectangle {
				anchors.fill: parent
				color: "#ffffff"
			}
		}

		Page{
			id: game
			width: parent.width
			height: parent.height
			enabled: (main.currentIndex == 1)

			Rectangle{
				id: rectangle1
				anchors.fill: parent
				color: "#ffffff"

				Rectangle {
					id: rectangle
					x: 50
					y: 50
					width: 300
					height: 300
					color: "#848484"
					radius: 4

					GridLayout {
						anchors.bottom: parent.bottom
						anchors.bottomMargin: 10
						anchors.top: parent.top
						anchors.topMargin: 10
						anchors.right: parent.right
						anchors.rightMargin: 10
						anchors.left: parent.left
						anchors.leftMargin: 10
						rows: 3
						columns: 3

						Component.onCompleted: {
							let r = [tic_1, tic_2, tic_3, tic_4, tic_5, tic_6, tic_7, tic_8, tic_9];
							for (let i=0; i<r.length; i++){
								Js.tic_buttons.push(r[i]);
							}
						}

						TicButton{
							id: tic_1
							Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
							toe: (Js.current_player === "O")

							onTicked:{
								Js.play(1);
							}

						}

						TicButton {
							id: tic_2
							Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
							toe: (Js.current_player === "O")

							onTicked:{
								Js.play(2);
							}
						}

						TicButton {
							id: tic_3
							Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
							toe: (Js.current_player === "O")

							onTicked:{
								Js.play(3);
							}
						}

						TicButton {
							id: tic_4
							Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
							toe: (Js.current_player === "O")

							onTicked:{
								Js.play(4);
							}
						}

						TicButton {
							id: tic_5
							Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
							toe: (Js.current_player === "O")

							onTicked:{
								Js.play(5);
							}
						}

						TicButton {
							id: tic_6
							Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
							toe: (Js.current_player === "O")

							onTicked:{
								Js.play(6);
							}
						}

						TicButton {
							id: tic_7
							Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
							toe: (Js.current_player === "O")

							onTicked:{
								Js.play(7);
							}
						}

						TicButton {
							id: tic_8
							Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
							toe: (Js.current_player === "O")

							onTicked:{
								Js.play(8);
							}
						}

						TicButton {
							id: tic_9
							Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
							toe: (Js.current_player === "O")

							onTicked:{
								Js.play(9);
							}
						}
					}
				}

				RowLayout {
					y: 17
					height: 17
					anchors.left: parent.left
					anchors.leftMargin: 50
					anchors.right: parent.right
					anchors.rightMargin: 50

					Label {
						id: label
						text: qsTr("human : "+String(score1))
						font.capitalization: Font.Capitalize
						font.family: "Montserrat"
						Layout.fillWidth: true
					}

					Label {
						id: label1
						text: qsTr("ai : "+String(score2))
						font.capitalization: Font.Capitalize
						font.family: "Montserrat"
						horizontalAlignment: Text.AlignRight
						Layout.fillWidth: true
					}
				}
			}
		}
	}

	onClosing:{
		Game.save()
	}

	Connections {
		target: root
		onNumberChosen: {
			if (number==1){
				tic_1.mark_card(toe);
			}else if (number==2){
				tic_2.mark_card(toe);
			}else if (number==3){
				tic_3.mark_card(toe);
			}else if (number==4){
				tic_4.mark_card(toe);
			}else if (number==5){
				tic_5.mark_card(toe);
			}else if (number==6){
				tic_6.mark_card(toe);
			}else if (number==7){
				tic_7.mark_card(toe);
			}else if (number==8){
				tic_8.mark_card(toe);
			}else if (number==9){
				tic_9.mark_card(toe);
			}
		}

		onPlayerWon:{
			if (player_id===0){
				score2+=1;
			}else if(player_id===1){
				score1+=1;
			}
			Js.reset_game();
		}
	}
}



/*##^## Designer {
    D{i:17;anchors_width:300;anchors_x:50}
}
 ##^##*/
