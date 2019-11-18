let player = {
	human: "X",
	computer: "O"
};
let tic_buttons = [];
let current_player = player.human;

function reset_game(){
	for (var i = 0; i < tic_buttons.length; i++) {
		tic_buttons[i].unmark_card();
	}
	let current_player = player.human;
	Game.reset()
}

const play = (number) => {
	if (Game.len_slot!=0){
		Game.player_pick(number, (current_player=="O"));
		current_player = player.computer;
		// Game.computer_pick((current_player=="O"));
		// current_player = player.computer;

		if (Game.len_slot!=0){
			Game.computer_pick((current_player=="O"));
			current_player = player.human;
			// Game.player_pick(number, (current_player=="O"));
			// current_player = player.human;
			if (Game.len_slot==0){
				// reset_game();
			}
		}else{
			// reset_game();
		}
	} else{
		// reset_game();
	}
}
