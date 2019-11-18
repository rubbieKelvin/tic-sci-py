import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtQuick.Controls.Material 2.0

Rectangle{
	id: root
	color: "#efefef";
	radius: 4
	width: 90
	height: 90

	property bool checked : false
	property bool toe : true
	signal ticked()

	function mark_card(is_toe) {
		toe = is_toe;
		checked = true;
		label.text = (toe) ? "O":"X";
		root.color = (toe) ? "#FFC107":"#28A745";
	}

	function unmark_card() {
		label.text = "";
		root.color = "#efefef";
		checked = false;
		toe = true;
	}

	Label{
		id: label
		color: "#deffffff"
		font.pointSize: 20
		font.weight: Font.Bold
		font.family: "Montserrat"
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		anchors.fill: parent
	}

	MouseArea {
	    anchors.fill: parent
	    cursorShape: Qt.PointingHandCursor
	    hoverEnabled: true
	    onEntered: {
			if (!checked){
				root.color = "#dfdfdf"
			}
		}
	    onExited: {
			if (!checked){
				root.color = "#efefef"
			}
		}
	    onClicked: {
			if (!checked){
				checked = !checked;
				ticked();
			}
		}
	}
}
