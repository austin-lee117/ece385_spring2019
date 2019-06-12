/************************************************************************
Avalon-MM Interface for AES Decryption IP Core

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department

Register Map:

 0-3 : 4x 32bit AES Key
 4-7 : 4x 32bit AES Encrypted Message
 8-11: 4x 32bit AES Decrypted Message
   12: Not Used
	13: Not Used
   14: 32bit Start Register
   15: 32bit Done Register

************************************************************************/

module avalon_aes_interface (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Exported Conduit
	output logic [31:0] EXPORT_DATA		// Exported Conduit Signal to LEDs
);

	logic [31:0] regs[16];	
	logic [127:0] msg_dec;
	logic AES_DONE;

//	AES aes_0(.*, .AES_START(regs[14][0]), .AES_KEY({regs[0], regs[1], regs[2], regs[3]}), 
//		.AES_MSG_ENC({regs[4], regs[5], regs[6], regs[7]}), 
//		.AES_MSG_DEC(msg_dec));
	
	always_ff @(posedge CLK) 
	begin
		if (RESET)
		begin
			for (int n = 0; n < 16; n++) 
				regs[n] <= 32'd0;
		end
	
		else if (AVL_WRITE & AVL_CS)
		begin
			regs[AVL_ADDR][7:0] <= (AVL_BYTE_EN[0])? AVL_WRITEDATA[7:0] : regs[AVL_ADDR][7:0];
			regs[AVL_ADDR][15:8] <= (AVL_BYTE_EN[1])? AVL_WRITEDATA[15:8] : regs[AVL_ADDR][15:8];
			regs[AVL_ADDR][23:16] <= (AVL_BYTE_EN[2])? AVL_WRITEDATA[23:16] : regs[AVL_ADDR][23:16]; 
			regs[AVL_ADDR][31:24] <= (AVL_BYTE_EN[3])? AVL_WRITEDATA[31:24] : regs[AVL_ADDR][31:24]; 			
			
		end
		else if (AES_DONE)
		begin
			regs[15][0] <= AES_DONE;
			regs[8] <= msg_dec[127:96];
			regs[9] <= msg_dec[95:64];
			regs[10] <= msg_dec[63:32];
			regs[11] <= msg_dec[31:0];
		end
	end
 
 	assign AVL_READDATA = (AVL_READ & AVL_CS) ? regs[AVL_ADDR] : 32'd0;
 	assign EXPORT_DATA = {regs[8][31:16], regs[11][15:0]}; 

	

endmodule
