module scorekeeper(input logic Clk, Reset, blackwon, whitewon, add,
							output logic [7:0] whitepoints, blackpoints);
							
							
	always_ff @ (posedge Clk)
	begin
	
	if(Reset)
	begin
	whitepoints <= 8'b00;
	blackpoints <= 8'b00;
	end
	else	if((blackwon) && (add))
	begin
		blackpoints = blackpoints + 1'b1;
	end
	else if ((whitewon)&&(add))
	begin
	whitepoints = whitepoints + 1'b1;
	
	end
	end
	
	//every time a player wins, add one point to respective player total!
	
endmodule
