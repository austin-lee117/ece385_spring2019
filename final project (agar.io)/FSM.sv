module FSM(
	input logic Clk, reset,
  input logic [7:0] keycode,
  input logic [1:0] gameover,
  output logic showtitle,
  //input logic temp,
  output logic Ball_X_Step, Ball_Y_Step,
  output logic blackwon, whitewon,
  output logic softreset,
  output logic add
);
  enum logic [4:0] {start, game, whitewins, blackwins, pausewhite, pauseblack} curr_state, next_state;
  
  
  always_ff @ (posedge Clk or posedge reset)
	begin
		if (reset)
			curr_state <= start;
		else
			curr_state <= next_state;
	end
  
  logic Enter;
  always_comb
    begin
      if(keycode == 8'h28)
        Enter = 1;
      else Enter = 0;
    end
	 
	 
	 
	 //state machine
	 //starts in the start state, waiting for ENTER key to start game
	 //plays game until one player wins
	 //when one player wins, enter a WIN state to add score to scorekeeper
	 //move to pause state to wait for ENTER key to start game over again
	 
  always_comb
    begin
				 next_state = curr_state;
					unique case (curr_state)
					  start: 
					  begin
					  if (Enter)
							next_state = game;
							end
					  game:
					 begin
					 if (gameover == 2'b01)
							next_state = whitewins;
					  else if (gameover == 2'b10)
								next_state = blackwins;
					end
					  whitewins: 
					  begin 
							next_state = pausewhite;
						end
					  blackwins: 
					  begin 
							next_state = pauseblack;
						end
						pausewhite:
						begin if(Enter)
							next_state = start;
							end
						pauseblack:
						begin if(Enter)
							next_state = start;
							end
					endcase
					
					end
					
					always_comb begin
					
					case (curr_state)
					
					pausewhite:
					begin
							blackwon = 0;
							whitewon = 1;
							showtitle = 1;
							Ball_X_Step = 0;
							Ball_Y_Step = 0;
							softreset = 0;
							add = 0;
							end
					pauseblack:
					begin
							blackwon = 1;
							whitewon = 0;
							showtitle = 1;
							Ball_X_Step = 0;
							Ball_Y_Step = 0;
							softreset = 0;
							add = 0;
					end
					  start:
						 begin
							blackwon = 0;
							whitewon = 0;
							showtitle = 1;
							Ball_X_Step = 0;
							Ball_Y_Step = 0;
							softreset = 0;
							add = 0;
						  end
						  
					blackwins:
						 begin
							blackwon = 1;
							whitewon = 0;
							Ball_X_Step = 0;
							Ball_Y_Step = 0;
							softreset = 1;
							showtitle = 0;
							add = 1;
						  end
				whitewins:
						 begin
							blackwon = 0;
							whitewon = 1;
							Ball_X_Step = 0;
							Ball_Y_Step = 0;
							softreset = 1;
							showtitle = 0;
							add = 1;
						  end
					game:
						 begin
							blackwon = 0;
							whitewon = 0;
							Ball_X_Step = 1;
							Ball_Y_Step = 1;
							softreset = 0;
							showtitle = 0;
							add = 0;
						  end
					default:
					begin
					end
					
				 endcase
				 
	 end
	 
	 endmodule 