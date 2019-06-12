module reg_16 (input logic [15:0] IN,
					input logic Clk, Load, Reset,
					output logic [15:0] OUT);
					
					always_ff @ (posedge Clk)
					begin
						if (~Reset)
							OUT = 16'h0;
						else 
							if (Load)
								OUT = IN;
					end
					endmodule
module regFile (input logic [15:0] bus,
						input logic [2:0] dr,sr2,sr1,
						input logic Clk, Load, Reset,
						output logic [15:0] sr2out, sr1out);
						
						logic [15:0] r0,r1,r2,r3,r4,r5,r6,r7;
						always_ff @ (posedge Clk)
						begin
							if(~Reset)
							begin
							r0 = 16'h0;
							r1 = 16'h0;
							r2 = 16'h0;
							r3 = 16'h0;
							r4 = 16'h0;
							r5 = 16'h0;
							r6 = 16'h0;
							r7 = 16'h0;
							end
							if (Load)
							begin
							 case(dr)
							 3'b000: r0 = bus;
							 3'b001: r1 = bus;
							 3'b010: r2 = bus;
							 3'b011: r3 = bus;
							 3'b100: r4 = bus;
							 3'b101: r5 = bus;
							 3'b110: r6 = bus;
							 3'b111: r7 = bus;
							 endcase
							 end
						 end
							 
							 always_comb
							 begin
							 case(sr1)
							 3'b000: sr1out = r0;
							 3'b001: sr1out = r1;
							 3'b010: sr1out = r2;
							 3'b011: sr1out = r3;
							 3'b100: sr1out = r4;
							 3'b101: sr1out = r5;
							 3'b110: sr1out = r6;
							 3'b111: sr1out = r7;
							 endcase
							 case(sr2)
							 3'b000: sr2out = r0;
							 3'b001: sr2out = r1;
							 3'b010: sr2out = r2;
							 3'b011: sr2out = r3;
							 3'b100: sr2out = r4;
							 3'b101: sr2out = r5;
							 3'b110: sr2out = r6;
							 3'b111: sr2out = r7;
								endcase
								end 
								
endmodule			
module branchenable (input logic Clk, Nin, Zin, Pin, LD_BEN,
							input logic [2:0] IN,
							output logic BEN);
							
						always_ff @(posedge Clk)
							begin
								if (LD_BEN)
								 BEN = (IN[2] & Nin) + (IN[1] & Zin) + (IN[0] & Pin);
								 end
								 endmodule
								 