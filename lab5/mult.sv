module mult(
input logic Clk,
input logic Reset,
input logic LoadB,
input logic Run,
input logic[7:0] S,
output logic X,
output logic [7:0]Aoutput,
output logic [7:0]Boutput,
output logic [6:0] AhexU, BhexU, AhexL, BhexL
);
logic x;
logic[7:0]A, B;
logic reset, loadB, run, a_shiftout, add, sub, ldb, shift;
logic[8:0] XA;
f_add adder(.A(A), .S(S), .on(add), .onsub(sub), .out(XA));
logic resA;
//f_sub subber(.A(A), .S(S), .on_sub(sub), .out(XA));
reg_8 regA (.Clk(Clk), .Reset(reset|ldb|resA), .Shift_In(x), 
				.Load(add|sub), .Shift_En(shift), .D(XA[7:0]), .Shift_Out(a_shiftout),
				.Data_Out(A));
reg_8 regB(.Clk(Clk), .Reset(reset|ldb), .Shift_In(a_shiftout), 
				.Load(ldb), .Shift_En(shift), .D(S), .Shift_Out(),
				.Data_Out(B));
reg_X regX(.Clk(CLk), .Reset(reset|ldb|resA), .Din(XA[8]), .Load(add|sub),.Dout(x));
control controlunit(.Clk(Clk), .Reset(reset), .LoadB(loadB), .Run(run), .lsb(B[0]),
						  .Shift_En(shift), .LdB(ldb), .Add(add), .Sub(sub), .resetA(resA));
						  
						  
assign Aoutput = A;
assign Boutput = B;
assign X = x;

HexDriver ahexU(.In0(A[7:4]), .Out0(AhexU)
);
HexDriver bhexU(.In0(B[7:4]), .Out0(BhexU)
);
HexDriver ahexL(.In0(A[3:0]), .Out0(AhexL)
);
HexDriver bhexL(.In0(B[3:0]), .Out0(BhexL)
);
sync syncer[2:0](Clk, {~Reset, ~LoadB, ~Run}, {reset, loadB, run});


//testbench bench1(.*);

endmodule 
