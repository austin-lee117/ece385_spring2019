module reg_8 (input  logic Clk, Reset, Shift_In, Load, Shift_En,
              input  logic [7:0]  D,
              output logic Shift_Out,
              output logic [7:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset)
			  Data_Out <= 8'h0;
		 else if (Load)
			  Data_Out <= D;
		 else if (Shift_En)
		 begin
			  Data_Out <= { Shift_In, Data_Out[7:1] }; 
	    end
    end
	
    assign Shift_Out = Data_Out[0];

endmodule

module reg_X(
	input logic Clk, Reset, Din, Load,
	output logic Dout);
	
	always_ff@(posedge Clk or posedge Reset)
	begin
		if(Reset)
			Dout <= 1'b0;
		else
		if(Load)
			Dout <= Din;
		else		
			Dout <= Dout;
	end
endmodule 
