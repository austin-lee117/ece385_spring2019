module PC_MUX (input logic [15:0] bus, adu, oldpc,  //adu is our adder, bus is bus, oldpc = pc+1
						input	logic [1:0] select,
						output logic [15:0] OUT);
						
						always_comb
						begin
						case(select)
							2'b00:
									OUT = oldpc;
							2'b01:
									OUT = adu;
							2'b10:
									OUT = bus;
							2'b11:
									OUT = 16'h0;  //never reaches state, it's a 3:1 mux
									
						endcase
						end
						endmodule 
module DR_MUX (input logic [2:0] ir    ,    //this serves as our DR_MUX, 3 bits from IR
						input logic select	,	//one select bit
						output logic [2:0] OUT);
					always_comb
					begin
					case(select)
					
						1'b0:
							OUT = ir;              //behavior based on select bit
						1'b1:
							OUT = 3'b111;
					endcase
					end
					endmodule

module busMUX (input logic [15:0] mar,pc,alu,mdr,
						input logic[3:0] select,
							output logic [15:0] OUT);
							always_comb
							begin
							case(select)
							
							4'b1000:
								OUT = mar;
							4'b0100:
								OUT = pc;
							4'b0010:
								OUT = alu;
							4'b0001:
								OUT = mdr;
							default:
								OUT = 16'h0;
							endcase
							end
							endmodule
module MDR_MUX (input logic [15:0] bus, mem,
						input logic select,
						output logic [15:0] OUT);
						always_comb
						begin
						case(select)
						
						2'b0:
							OUT = bus;
						2'b1:
							OUT = mem;
							endcase
							end
							endmodule
module SR1_MUX (input logic [2:0] ir1, ir2,
						input logic select,
						output logic [2:0] OUT);
						always_comb
						begin
						case(select)
						
						1'b0:
							OUT = ir1;
						1'b1:
							OUT = ir2;
							endcase
							end
							endmodule
module SR2_MUX (input logic [15:0] regf, ir,
						input logic select,
							output logic [15:0] OUT);
							always_comb
							begin
							case(select)
							
							1'b0:
								OUT = regf;
							1'b1:
								OUT = ir;
							endcase
							end
							endmodule
module ADDR1_MUX (input logic [15:0] pc, sr1,
							input logic select,
							output logic [15:0] OUT);
							always_comb
							begin
							case(select)
							
							1'b0:
								OUT = pc;
							1'b1:
								OUT = sr1;
								endcase
								end
								endmodule
module ADDR2_MUX (input logic [15:0] sixsext, ninesext, elevensext,
								input logic [1:0] select,
								output logic [15:0] OUT);
								always_comb
								begin
								case(select)
								
								2'b00:
									OUT = 16'h0;
								2'b01:
									OUT = sixsext;
								2'b10:
									OUT = ninesext;
								2'b11:
									OUT = elevensext;
									endcase
									end
									endmodule
									
					