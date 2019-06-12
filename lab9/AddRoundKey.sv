module AddRoundKey(input [127:0] state, input [3:0] roundkey,
						output [127:0] out);
						
		
		
	assign out = state ^ roundkey;	
			
endmodule 