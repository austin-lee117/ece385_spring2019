module testbench();

timeunit 10ns;
timeprecision 1ns;

logic [15:0] S;
logic Clk, Reset, Run, Continue;
logic [11:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
logic CE, UB, LB, OE, WE;
logic [19:0] ADDR;
wire [15:0] Data;
 always begin: CLOCK_GENERATE
	# 1 Clk = ~Clk;
	end
	
	initial begin: CLOCK_INITIALIZE
	Clk = 0;
	end
	
	lab6_toplevel test(.*);
	
	
	logic[15:0] MAR, MDR, IR, PC;
	always_comb
	begin
//	PC = test.my_slc.PC;
//	MAR = test.my_slc.MAR;
//	MDR = test.my_slc.MDR;
//	IR = test.my_slc.IR;
	end
	
	
	initial begin: TEST_VECTORS
	Reset= 1'b1;
	Run = 1'b1;
	Continue = 1'b1;
	S = 16'h0000;
	
	#1 Reset = 1'b0;
	#2 Reset = 1'b1;
	
	#1 Run = 1'b0;
	#4 Run = 1'b1;
	#8 Continue = 1'b0;
	#8 Continue = 1'b1;
	#8 Continue = 1'b0;
	#8 Continue = 1'b1;
	
	#8 Continue = 1'b0;
	#8 Continue = 1'b1;
	#8 Continue = 1'b0;
	#8 Continue = 1'b1;
	
	end
endmodule 