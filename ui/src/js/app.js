var ChartLineData = {
      labels: ["round1","round2","round3","round4","round5"],
    datasets: [{
               fillColor: "#80007bff",
             strokeColor: "#007bff",
              pointColor: "rgba(33,150,243,1)",
        pointStrokeColor: "#ffffff",
                    data: [12, 2, 4, 10, 9]
    }, {
               fillColor: "#8028a745",
             strokeColor: "#28a745",
              pointColor: "rgba(139,195,74,1)",
        pointStrokeColor: "#ffffff",
                    data: [1, 23, 11, 4, 11]
    }]
};

let player = {human: "X", ai: "O"};
let current = player.human;

const next_player = () => {
	if (!play_space.is_full()){
		current = (current===player.human)?player.ai:player.human;
		root.emit_next(current);
	}
}

const human_pick = (id) => {
	// when a human picks number, collect and register it
	Game.record(player.human, id);
	// then wait for next player to pick
	next_player();
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

	// wait for next player
	next_player();
}
