module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);
	

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	logic c[3:0];
	select_helper CSA0(.A(A[3:0]), .B(B[3:0]), .c_in(1'b0), .Sum(Sum[3:0]), .CO(c[0]));
	select_helper CSA1(.A(A[7:4]), .B(B[7:4]), .c_in(c[0]), .Sum(Sum[7:4]), .CO(c[1]));
	select_helper CSA2(.A(A[11:8]), .B(B[11:8]), .c_in(c[1]), .Sum(Sum[11:8]), .CO(c[2]));
	select_helper CSA3(.A(A[15:12]), .B(B[15:12]), .c_in(c[2]), .Sum(Sum[15:12]), .CO(CO));
     
endmodule

module select_helper (
	input logic [3:0] A,
	input logic [3:0] B,
	input logic c_in,
	output logic[3:0] Sum,
	output logic CO
	);
	logic[3:0] sum0; //sum for carry = 0
	logic[3:0] sum1; //sum for carry = 1
	logic c0[3:0];
	logic c1[3:0];
	//carry bit = 0
	full_adder FA0C0(.x(A[0]), .y(B[0]), .z(1'b0), .s(sum0[0]), .c(c0[0]));
	full_adder FA1C0(.x(A[1]), .y(B[1]), .z(c0[0]), .s(sum0[1]), .c(c0[1]));
	full_adder FA2C0(.x(A[2]), .y(B[2]), .z(c0[1]), .s(sum0[2]), .c(c0[2]));
	full_adder FA3C0(.x(A[3]), .y(B[3]), .z(c0[2]), .s(sum0[3]), .c(c0[3]));
	//carry bit = 1
	full_adder FA0C1(.x(A[0]), .y(B[0]), .z(1'b1), .s(sum1[0]), .c(c1[0]));
	full_adder FA1C1(.x(A[1]), .y(B[1]), .z(c1[0]), .s(sum1[1]), .c(c1[1]));
	full_adder FA2C1(.x(A[2]), .y(B[2]), .z(c1[1]), .s(sum1[2]), .c(c1[2]));
	full_adder FA3C1(.x(A[3]), .y(B[3]), .z(c1[2]), .s(sum1[3]), .c(c1[3]));
	
	always_comb
	begin
		if (c_in ==0) begin
		Sum = sum0;
		CO = c0[3];
		end
		else begin
		Sum = sum1;
		CO = c1[3];
		end
	end
	
endmodule 