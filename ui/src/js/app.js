let ScoreData = {
      labels: ["0"],
    datasets: [{
               fillColor: "#80007bff",
             strokeColor: "#007bff",
              pointColor: "rgba(33,150,243,1)",
        pointStrokeColor: "#ffffff",
                    data: [0]
    }, {
               fillColor: "#8028a745",
             strokeColor: "#28a745",
              pointColor: "rgba(139,195,74,1)",
        pointStrokeColor: "#ffffff",
                    data: [0]
    }]
};
let target = 0;
let player = {human: "X", ai: "O"};
let current = player.human;

const settarget = (num) => {
	target = 0;
}

const setcurrent = (player) => {
	current = player;
}

const next_player = () => {
	if (!play_space.is_full()){
		current = (current===player.human)?player.ai:player.human;
		root.emit_next(current);
	}
}

const human_pick = (id) => {
	// when a human picks number, collect and register it
	Game.record(player.human, id);

	// check if player has won
	if (Game.checkwinner(player.human)){
		console.log("human won");
		target = -1;
		play_space.reset_pad();
	}else{
		next_player();
	}
}

const ai_pick = () => {
	// js ai :: start
	let num = 0;
	let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9];
	let anums = [];
	for (var i = 0; i < nums.length; i++) {
		if (play_space.is_available(nums[i])){
			anums.push(nums[i]);
			// num = nums[i];
			// break;
		}
	}
	let n_ = JSON.stringify(anums);
	num = Bot.guess(n_);
	// js ai :: end

	play_space.mark(num);
	// register the number
	Game.record(player.ai, num);

	// check if ai has won
	if (Game.checkwinner(player.ai)){
		target = 1;
		play_space.reset_pad();
	}else{
		next_player();
	}
}


const updatechart = (round, human, ai) =>{
	// make sure there is at most 6 points on graph
	if (ScoreData.labels.length > 5){
		let l = [];
		let d1 = [];
		let d2 = [];
		for (var i = 1; i < ScoreData.labels.length; i++) {
			l.push(ScoreData.labels[i]);
			d1.push(ScoreData.datasets[0].data[i])
			d2.push(ScoreData.datasets[1].data[i])
		}
		ScoreData.labels = l;
		ScoreData.datasets[0].data = d1;
		ScoreData.datasets[1].data = d2;
	}

	// put data
	ScoreData.labels.push(String(round));
	ScoreData.datasets[0].data.push(ai);
	ScoreData.datasets[1].data.push(human);

	console.log(ScoreData.labels)
	console.log(ScoreData.datasets[0].data)
	console.log(ScoreData.datasets[1].data)

	let ctx = chart_line.getContext("2d");
	ctx.reset();
	chart_line.chartData = ScoreData;
	chart_line.repaint();
}
