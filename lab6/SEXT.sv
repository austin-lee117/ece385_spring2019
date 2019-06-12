module fivesext( input logic [4:0] IN,
						output logic [15:0] OUT);
						
						always_comb
						begin 
						if (IN[4])
							OUT[15:5] = 11'b1;
						else
							OUT[15:5] = 11'b0;
						OUT[4:0] = IN[4:0];
					end
				endmodule
module sixsext(input logic [5:0] IN,
					output logic [15:0] OUT);
					always_comb
						begin 
						if (IN[5])
							OUT[15:6] = 10'b1;
						else
							OUT[15:6] = 10'b0;
						OUT[5:0] = IN[5:0];
					end
				endmodule
				
module ninesext(input logic [8:0] IN,
					output logic [15:0] OUT);
					always_comb
						begin 
						if (IN[8])
							OUT[15:9] = 7'b1;
						else
							OUT[15:9] = 7'b0;
						OUT[8:0] = IN[8:0];
					end
				endmodule
module elevensext(input logic [10:0] IN,
					output logic [15:0] OUT);
					always_comb
						begin 
						if (IN[10])
							OUT[15:11] = 5'b1;
						else
							OUT[15:11] = 5'b0;
						OUT[10:0] = IN[10:0];
					end
				endmodule												