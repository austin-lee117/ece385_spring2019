module NZP(input logic Clk, Nin, Zin, Pin, LD_CC,
				output logic Nout, Zout, Pout);
				
				always_ff @ (posedge Clk)
				begin
				if (LD_CC)
				begin
					Nout = Nin;
					Zout = Zin;
					Pout = Pin;
				end
				end
				endmodule 