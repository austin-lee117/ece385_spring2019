module f_sub (
	input logic[7:0] A,
	input logic[7:0] S,
	input logic on_sub, 
	output logic[8:0] out
	);

	logic[8:0] a;
	logic[8:0] s;
	logic[8:0] stemp;
	logic[8:0] scomp;
	logic[7:0] c;
	logic[7:0] d;
		
	sext extendedA(.in(A), .out(a));
	sext extendedS(.in(S), .out(s));
	
	assign stemp = ~s;
	full_adder FA0(.x(a[0]), .y(1'b1), .z(1'b0), .s(scomp[0]), .c(c[0]));
	full_adder FA1(.x(a[1]), .y(1'b0), .z(c[0]), .s(scomp[1]), .c(c[1]));
	full_adder FA2(.x(a[2]), .y(1'b0), .z(c[1]), .s(scomp[2]), .c(c[2]));
	full_adder FA3(.x(a[3]), .y(1'b0), .z(c[2]), .s(scomp[3]), .c(c[3]));
	full_adder FA4(.x(a[4]), .y(1'b0), .z(c[3]), .s(scomp[4]), .c(c[4]));
	full_adder FA5(.x(a[5]), .y(1'b0), .z(c[4]), .s(scomp[5]), .c(c[5]));
	full_adder FA6(.x(a[6]), .y(1'b0), .z(c[5]), .s(scomp[6]), .c(c[6]));
	full_adder FA7(.x(a[7]), .y(1'b0), .z(c[6]), .s(scomp[7]), .c(c[7]));
	full_adder FA8(.x(a[8]), .y(1'b0), .z(c[7]), .s(scomp[8]), .c());
	
	full_adder FA10(.x(a[0]), .y(scomp[0]), .z(1'b0), .s(out[0]), .c(d[0]));
	full_adder FA11(.x(a[1]), .y(scomp[1]), .z(d[0]), .s(out[1]), .c(d[1]));
	full_adder FA12(.x(a[2]), .y(scomp[2]), .z(d[1]), .s(out[2]), .c(d[2]));
	full_adder FA13(.x(a[3]), .y(scomp[3]), .z(d[2]), .s(out[3]), .c(d[3]));
	full_adder FA14(.x(a[4]), .y(scomp[4]), .z(d[3]), .s(out[4]), .c(d[4]));
	full_adder FA15(.x(a[5]), .y(scomp[5]), .z(d[4]), .s(out[5]), .c(d[5]));
	full_adder FA16(.x(a[6]), .y(scomp[6]), .z(d[5]), .s(out[6]), .c(d[6]));
	full_adder FA17(.x(a[7]), .y(scomp[7]), .z(d[6]), .s(out[7]), .c(d[7]));
	full_adder FA18(.x(a[8]), .y(scomp[8]), .z(d[7]), .s(out[8]), .c());
	
	always begin
	if(~on_sub)
	out = A;
	end
	
endmodule
