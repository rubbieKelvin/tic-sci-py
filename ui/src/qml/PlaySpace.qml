import QtQuick 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.0
import "../js/PlaySpace.js" as Js

Rectangle {
	id: root
	width: 300
	height: 300
	color: "#e2e2e2"

	property string mark_color
	property string mark_text
	signal click(int number)
	signal resetStarted()
	signal resetEnded()

	Component.onCompleted: {

	}

	Timer{
		id: reset_timer
		interval: 2000
		onRunningChanged:{
			if (running){
				resetStarted();
			}
		}
		onTriggered: {
			Js.Pad.reset();
			resetEnded();
		}
	}

	function reset_pad() {
	    reset_timer.start()
	}

	function is_available(id) {
	    return !Js.Pad.marked(id);
	}

	function is_full() {
	    return (Js.Pad.marks.length === 9);
	}

	function mark(id) {
	    Js.Pad.mark(id);

		if (id===1){
			rectangle1.color = mark_color;
			label1.text = mark_text;
		}else if (id===2){
			rectangle2.color = mark_color;
			label2.text = mark_text;
		}else if (id===3){
			rectangle3.color = mark_color;
			label3.text = mark_text;
		}else if (id===4){
			rectangle4.color = mark_color;
			label4.text = mark_text;
		}else if (id===5){
			rectangle5.color = mark_color;
			label5.text = mark_text;
		}else if (id===6){
			rectangle6.color = mark_color;
			label6.text = mark_text;
		}else if (id===7){
			rectangle7.color = mark_color;
			label7.text = mark_text;
		}else if (id===8){
			rectangle8.color = mark_color;
			label8.text = mark_text;
		}else if (id===9){
			rectangle9.color = mark_color;
			label9.text = mark_text;
		}
	}

	GridLayout {
		anchors.top: parent.top
		anchors.topMargin: 8
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 8
		anchors.right: parent.right
		anchors.rightMargin: 8
		anchors.left: parent.left
		anchors.leftMargin: 8
		rows: 3
		columns: 3

		Rectangle {
			id: rectangle1
			color: "#ffffff"
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.preferredHeight: 104
			Layout.preferredWidth: 86

			Label {
				id: label1
				color: "#ffffff"
				font.capitalization: Font.AllUppercase
				font.weight: Font.Bold
				font.pointSize: 18
				font.family: "Montserrat"
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
				anchors.fill: parent
			}

			MouseArea {
			    anchors.fill: parent
			    cursorShape: Qt.PointingHandCursor
			    hoverEnabled: true
			    onEntered: {}
			    onExited: {}
			    onClicked: {
					if (!Js.Pad.marked(1)){
						Js.Pad.mark(1);
						parent.color = mark_color;
						label1.text = mark_text;
						click(1);
					}
				}
			}

		}

		Rectangle {
			id: rectangle2
			color: "#ffffff"
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.preferredHeight: 104
			Layout.preferredWidth: 86

			Label {
				id: label2
				color: "#ffffff"
				font.capitalization: Font.AllUppercase
				font.weight: Font.Bold
				font.pointSize: 18
				font.family: "Montserrat"
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
				anchors.fill: parent
			}

			MouseArea {
			    anchors.fill: parent
			    cursorShape: Qt.PointingHandCursor
			    hoverEnabled: true
			    onEntered: {}
			    onExited: {}
			    onClicked: {
					if (!Js.Pad.marked(2)){
						Js.Pad.mark(2);
						parent.color = mark_color;
						label2.text = mark_text;
						click(2);
					}
				}
			}
		}

		Rectangle {
			id: rectangle3
			color: "#ffffff"
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.preferredHeight: 104
			Layout.preferredWidth: 86

			Label {
				id: label3
				color: "#ffffff"
				font.capitalization: Font.AllUppercase
				font.weight: Font.Bold
				font.pointSize: 18
				font.family: "Montserrat"
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
				anchors.fill: parent
			}

			MouseArea {
			    anchors.fill: parent
			    cursorShape: Qt.PointingHandCursor
			    hoverEnabled: true
			    onEntered: {}
			    onExited: {}
			    onClicked: {
					if (!Js.Pad.marked(3)){
						Js.Pad.mark(3);
						parent.color = mark_color;
						label3.text = mark_text;
						click(3);
					}
				}
			}
		}

		Rectangle {
			id: rectangle4
			color: "#ffffff"
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.preferredHeight: 104
			Layout.preferredWidth: 86

			Label {
				id: label4
				color: "#ffffff"
				font.capitalization: Font.AllUppercase
				font.weight: Font.Bold
				font.pointSize: 18
				font.family: "Montserrat"
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
				anchors.fill: parent
			}

			MouseArea {
			    anchors.fill: parent
			    cursorShape: Qt.PointingHandCursor
			    hoverEnabled: true
			    onEntered: {}
			    onExited: {}
			    onClicked: {
					if (!Js.Pad.marked(4)){
						Js.Pad.mark(4);
						parent.color = mark_color;
						label4.text = mark_text;
						click(4);
					}
				}
			}
		}

		Rectangle {
			id: rectangle5
			color: "#ffffff"
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.preferredHeight: 104
			Layout.preferredWidth: 86

			Label {
				id: label5
				color: "#ffffff"
				font.capitalization: Font.AllUppercase
				font.weight: Font.Bold
				font.pointSize: 18
				font.family: "Montserrat"
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
				anchors.fill: parent
			}

			MouseArea {
			    anchors.fill: parent
			    cursorShape: Qt.PointingHandCursor
			    hoverEnabled: true
			    onEntered: {}
			    onExited: {}
			    onClicked: {
					if (!Js.Pad.marked(5)){
						Js.Pad.mark(5);
						parent.color = mark_color;
						label5.text = mark_text;
						click(5);
					}
				}
			}
		}

		Rectangle {
			id: rectangle6
			color: "#ffffff"
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.preferredHeight: 104
			Layout.preferredWidth: 86

			Label {
				id: label6
				color: "#ffffff"
				font.capitalization: Font.AllUppercase
				font.weight: Font.Bold
				font.pointSize: 18
				font.family: "Montserrat"
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
				anchors.fill: parent
			}

			MouseArea {
			    anchors.fill: parent
			    cursorShape: Qt.PointingHandCursor
			    hoverEnabled: true
			    onEntered: {}
			    onExited: {}
			    onClicked: {
					if (!Js.Pad.marked(6)){
						Js.Pad.mark(6);
						parent.color = mark_color;
						label6.text = mark_text;
						click(6);
					}
				}
			}
		}

		Rectangle {
			id: rectangle7
			color: "#ffffff"
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.preferredHeight: 104
			Layout.preferredWidth: 86

			Label {
				id: label7
				color: "#ffffff"
				font.capitalization: Font.AllUppercase
				font.weight: Font.Bold
				font.pointSize: 18
				font.family: "Montserrat"
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
				anchors.fill: parent
			}

			MouseArea {
			    anchors.fill: parent
			    cursorShape: Qt.PointingHandCursor
			    hoverEnabled: true
			    onEntered: {}
			    onExited: {}
			    onClicked: {
					if (!Js.Pad.marked(7)){
						Js.Pad.mark(7);
						parent.color = mark_color;
						label7.text = mark_text;
						click(7);
					}
				}
			}
		}

		Rectangle {
			id: rectangle8
			color: "#ffffff"
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.preferredHeight: 104
			Layout.preferredWidth: 86

			Label {
				id: label8
				color: "#ffffff"
				font.capitalization: Font.AllUppercase
				font.weight: Font.Bold
				font.pointSize: 18
				font.family: "Montserrat"
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
				anchors.fill: parent
			}

			MouseArea {
			    anchors.fill: parent
			    cursorShape: Qt.PointingHandCursor
			    hoverEnabled: true
			    onEntered: {}
			    onExited: {}
			    onClicked: {
					if (!Js.Pad.marked(8)){
						Js.Pad.mark(8);
						parent.color = mark_color;
						label8.text = mark_text;
						click(8);
					}
				}
			}
		}

		Rectangle {
			id: rectangle9
			color: "#ffffff"
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.preferredHeight: 104
			Layout.preferredWidth: 86

			Label {
				id: label9
				color: "#ffffff"
				font.capitalization: Font.AllUppercase
				font.weight: Font.Bold
				font.pointSize: 18
				font.family: "Montserrat"
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
				anchors.fill: parent
			}

			MouseArea {
			    anchors.fill: parent
			    cursorShape: Qt.PointingHandCursor
			    hoverEnabled: true
			    onEntered: {}
			    onExited: {}
			    onClicked: {
					if (!Js.Pad.marked(9)){
						Js.Pad.mark(9);
						parent.color = mark_color;
						label9.text = mark_text;
						click(9);
					}
				}
			}
		}
	}
}
