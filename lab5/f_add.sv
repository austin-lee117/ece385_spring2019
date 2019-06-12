module f_add (
	input logic[7:0] A,
	input logic[7:0] S,
	input logic on,
	input logic onsub,
	output logic[8:0] out
	);

	logic[8:0] a;
	logic[8:0] s;
	logic[7:0] c;
	logic[7:0] c2;
	logic[8:0] stemp;
	logic[8:0] scomp;
	logic[7:0] d;
	logic[8:0] outadd;
	logic[8:0] outsub;
	
	sext extendedA(.in(A), .out(a));
	sext extendedS(.in(S), .out(s));
	
	full_adder FA0(.x(a[0]), .y(s[0]), .z(1'b0), .s(outadd[0]), .c(c[0]));
	full_adder FA1(.x(a[1]), .y(s[1]), .z(c[0]), .s(outadd[1]), .c(c[1]));
	full_adder FA2(.x(a[2]), .y(s[2]), .z(c[1]), .s(outadd[2]), .c(c[2]));
	full_adder FA3(.x(a[3]), .y(s[3]), .z(c[2]), .s(outadd[3]), .c(c[3]));
	full_adder FA4(.x(a[4]), .y(s[4]), .z(c[3]), .s(outadd[4]), .c(c[4]));
	full_adder FA5(.x(a[5]), .y(s[5]), .z(c[4]), .s(outadd[5]), .c(c[5]));
	full_adder FA6(.x(a[6]), .y(s[6]), .z(c[5]), .s(outadd[6]), .c(c[6]));
	full_adder FA7(.x(a[7]), .y(s[7]), .z(c[6]), .s(outadd[7]), .c(c[7]));
	full_adder FA8(.x(a[8]), .y(s[8]), .z(c[7]), .s(outadd[8]), .c());
		
	assign stemp = ~s;
	
	full_adder FA10(.x(stemp[0]), .y(1'b1), .z(1'b0), .s(scomp[0]), .c(c2[0]));
	full_adder FA11(.x(stemp[1]), .y(1'b0), .z(c2[0]), .s(scomp[1]), .c(c2[1]));
	full_adder FA12(.x(stemp[2]), .y(1'b0), .z(c2[1]), .s(scomp[2]), .c(c2[2]));
	full_adder FA13(.x(stemp[3]), .y(1'b0), .z(c2[2]), .s(scomp[3]), .c(c2[3]));
	full_adder FA14(.x(stemp[4]), .y(1'b0), .z(c2[3]), .s(scomp[4]), .c(c2[4]));
	full_adder FA15(.x(stemp[5]), .y(1'b0), .z(c2[4]), .s(scomp[5]), .c(c2[5]));
	full_adder FA16(.x(stemp[6]), .y(1'b0), .z(c2[5]), .s(scomp[6]), .c(c2[6]));
	full_adder FA17(.x(stemp[7]), .y(1'b0), .z(c2[6]), .s(scomp[7]), .c(c2[7]));
	full_adder FA18(.x(stemp[8]), .y(1'b0), .z(c2[7]), .s(scomp[8]), .c());
	
	full_adder FA20(.x(a[0]), .y(scomp[0]), .z(1'b0), .s(outsub[0]), .c(d[0]));
	full_adder FA21(.x(a[1]), .y(scomp[1]), .z(d[0]), .s(outsub[1]), .c(d[1]));
	full_adder FA22(.x(a[2]), .y(scomp[2]), .z(d[1]), .s(outsub[2]), .c(d[2]));
	full_adder FA23(.x(a[3]), .y(scomp[3]), .z(d[2]), .s(outsub[3]), .c(d[3]));
	full_adder FA24(.x(a[4]), .y(scomp[4]), .z(d[3]), .s(outsub[4]), .c(d[4]));
	full_adder FA25(.x(a[5]), .y(scomp[5]), .z(d[4]), .s(outsub[5]), .c(d[5]));
	full_adder FA26(.x(a[6]), .y(scomp[6]), .z(d[5]), .s(outsub[6]), .c(d[6]));
	full_adder FA27(.x(a[7]), .y(scomp[7]), .z(d[6]), .s(outsub[7]), .c(d[7]));
	full_adder FA28(.x(a[8]), .y(scomp[8]), .z(d[7]), .s(outsub[8]), .c());
	
	always_comb
	if(on)
	out = outadd;
	else if(onsub)
	out = outsub;
	else
	out = 9'b0;
	
	
	
	
endmodule


module sext (
	input signed[7:0] in,
	output signed[8:0] out
	);
	assign out = in;
endmodule
	