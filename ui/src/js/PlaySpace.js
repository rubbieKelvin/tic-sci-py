let Pad = {
	marks: [],
	mark: function(id){
		this.marks.push(id);
		if (this.marks.length === 9){
			root.enabled = false;
			console.log("box is already full... reseting");
			root.reset_pad();
		}
	},
	marked: function(id){
		for (var i = 0; i < this.marks.length; i++) {
			if(this.marks[i]===id){
				return true;
			}
		}
		return false;
	},
	reset: function(){
		// for (let i=0; i<this.marks.length; i++){
		// 	this.marks.pop();
		// }
		this.marks = [];

		// clear pads
		let pads = [[rectangle1, label1],
				[rectangle2, label2],
				[rectangle3, label3],
				[rectangle4, label4],
				[rectangle5, label5],
				[rectangle6, label6],
				[rectangle7, label7],
				[rectangle8, label8],
				[rectangle9, label9]
			]
		for (var i = 0; i < pads.length; i++) {
			pads[i][0].color = "#ffffff";
			pads[i][1].text = "";
		}
		root.enabled = true;
	}
};
