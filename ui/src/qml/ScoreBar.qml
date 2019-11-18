import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtQuick.Controls.Material 2.0

Rectangle {
	id: root
	clip: true
	color: "#17a2b8"
	height: 40
	radius: 6
	width: 118

	property string play_role
	property int score: 0

	Rectangle {
		id: rectangle1
		x: 62
		y: 0
		width: 56
		height: 40
		color: "#eeeeee"
		radius: root.radius
		anchors.right: parent.right
		anchors.rightMargin: -2
		clip: true

		Label {
			text: qsTr(String(score))
			font.family: "Montserrat"
			anchors.rightMargin: -1
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
			anchors.fill: parent
		}
	}

	Label {
		color: "#deffffff"
		text: qsTr(play_role)
		font.family: "Montserrat"
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		anchors.right: rectangle1.left
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.rightMargin: 0
	}

	Rectangle {
		id: rectangle
		x: 57
		width: 12
		color: rectangle1.color
		anchors.top: parent.top
		anchors.topMargin: 0
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 0
		anchors.right: rectangle1.left
		anchors.rightMargin: -7
	}
}









/*##^## Designer {
    D{i:1;anchors_width:56;anchors_x:62}D{i:4;anchors_height:40;anchors_y:0}
}
 ##^##*/
