module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic Clk;
logic Reset, LoadB, Run;
logic [7:0] S;
logic X;
logic [7:0] Aoutput;
logic [7:0] Boutput;
logic [6:0] AhexU, BhexU, AhexL, BhexL;

mult Mult(.*);

always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

//mult Mult(.Clk(Clk), .Reset(Reset), .LoadB(LoadB), .Run(Run), .S(S), .X(X), .Aoutput(Aoutput), .Boutput(Boutput), .AhexU(AhexU), .BhexU(BhexU), .AhexL(AhexL), .BhexL(BhexL));

initial begin : TEST_VECTORS

Reset = 0;
S = 8'b00000010;
Run = 1;
LoadB = 1;

#2 

Reset = 1;
LoadB = 0;

#2
S = 8'b00000010;

#2
LoadB = 1;

#2 

LoadB = 0;
S = 8'b00000010;

#2
LoadB = 1;
Run = 0;

#2
Run = 1;

#2 
Run = 0;

#2
Run = 1;
end
endmodule