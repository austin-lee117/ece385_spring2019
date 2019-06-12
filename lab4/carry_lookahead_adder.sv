module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

logic c1, c2, c3;
logic g0, g1, g2, g3;
logic p0, p1, p2, p3;

lookahead_helper LA0(.A(A[3:0]), .B(B[3:0]), .c_in(1'b0), .sum(Sum[3:0]), .po(p0), .go(g0));
lookahead_helper LA1(.A(A[7:4]), .B(B[7:4]), .c_in(c1), .sum(Sum[7:4]), .po(p1), .go(g1));
lookahead_helper LA2(.A(A[11:8]), .B(B[11:8]), .c_in(c2), .sum(Sum[11:8]), .po(p2), .go(g2));
lookahead_helper LA3(.A(A[15:12]), .B(B[15:12]), .c_in(c3), .sum(Sum[15:12]), .po(p3), .go(g3));

always_comb
begin
	c1 = (1'b0 & p0) | g0; 
	c2 = (1'b0 & p0 & p1) | (g0 & p1) | g1;
	c3 = (1'b0 & p0 & p1 & p2) | (g0 & p1 & p2) | (g1 & p2) | g2;
	CO = (1'b0 & p0 & p1 & p2 & p3) | (g0 & p1 & p2 & p3) | (g1 & p2 & p3) | (g2 & p3) | g3;	
end

endmodule



module lookahead_helper(
	input logic [3:0] A,
	input logic [3:0] B,
	input logic c_in,
	output logic [3:0] sum,
	output logic go,
	output logic po
);

	logic c1;
	logic c2;
	logic c3;
	logic [3:0] g;
	assign g = A&B;
	logic [3:0] p;
	assign p = A ^ B;
	
	always_comb
	begin
		
		c1 = (c_in & p[0]) | g[0];
		c2 = (c_in & p[0] & p[1]) | (g[0] & p[1]) | g[1];
		c3 = (c_in & p[0] & p[1] & p[2]) | (g[0] & p[1] & p[2]) | (g[1] & p[2]) | g[2];
		po = p[0] & p[1] & p[2] & p[3];
		go = g[3] | (g[2] & p[3]) | (g[1] & p[3] & p[2]) | (g[0] & p[3] & p[2] & p[1]);
	end
	full_adder FA0(.x(A[0]), .y(B[0]), .z(c_in), .s(sum[0]));
	full_adder FA1(.x(A[1]), .y(B[1]), .z(c1), .s(sum[1]));
	full_adder FA2(.x(A[2]), .y(B[2]), .z(c2), .s(sum[2]));
	full_adder FA3(.x(A[3]), .y(B[3]), .z(c3), .s(sum[3]));
	
endmodule 