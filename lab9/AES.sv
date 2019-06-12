/************************************************************************
AES Decryption Core Logic

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

module AES (
	input	 logic CLK,
	input  logic RESET,
	input  logic AES_START,
	output logic AES_DONE,
	input  logic [127:0] AES_KEY,
	input  logic [127:0] AES_MSG_ENC,
	output logic [127:0] AES_MSG_DEC
);

logic [1407:0] key_schedule;



logic [3:0] round, round_next;
logic[127:0] state, tempstate;
logic[127:0] addout, shiftout, subout;
logic[31:0] mixin, mixout;
logic[127:0] roundkey;

enum logic[4:0] {start, done, addrk0, addrk, expand, shift, sub, mix0, mix1, mix2, mix3, save0, save1, save2, save3, pause, looppause} curr, next;


AddRoundKey ark0(.state(state), .roundkey(roundkey), .out(addout));

KeyExpansion keyexpander(.clk(CLK), .Cipherkey(AES_KEY), .KeySchedule(key_schedule));

InvMixColumns mixcol(.in(mixin), .out(mixout));

InvShiftRows shiftrow(.data_in(state), .data_out(shiftout));

InvSubBytes isb0(.clk(CLK), .in(state[7:0]), .out(subout[7:0]));
InvSubBytes isb1(.clk(CLK), .in(state[15:8]), .out(subout[15:8]));
InvSubBytes isb2(.clk(CLK), .in(state[23:16]), .out(subout[23:16]));
InvSubBytes isb3(.clk(CLK), .in(state[31:24]), .out(subout[31:24]));
InvSubBytes isb4(.clk(CLK), .in(state[39:32]), .out(subout[39:32]));
InvSubBytes isb5(.clk(CLK), .in(state[47:40]), .out(subout[47:40]));
InvSubBytes isb6(.clk(CLK), .in(state[55:48]), .out(subout[55:48]));
InvSubBytes isb7(.clk(CLK), .in(state[63:56]), .out(subout[63:56]));
InvSubBytes isb8(.clk(CLK), .in(state[71:64]), .out(subout[71:64]));
InvSubBytes isb9(.clk(CLK), .in(state[79:72]), .out(subout[79:72]));
InvSubBytes isb10(.clk(CLK), .in(state[87:80]), .out(subout[87:80]));
InvSubBytes isb11(.clk(CLK), .in(state[95:88]), .out(subout[95:88]));
InvSubBytes isb12(.clk(CLK), .in(state[103:96]), .out(subout[103:96]));
InvSubBytes isb13(.clk(CLK), .in(state[111:104]), .out(subout[111:104]));
InvSubBytes isb14(.clk(CLK), .in(state[119:112]), .out(subout[119:112]));
InvSubBytes isb15(.clk(CLK), .in(state[127:120]), .out(subout[127:120]));



always_ff @ (posedge CLK) 
begin
if(RESET)
	begin
	curr <= start;
	round <= 4'b0;

  end //end if reset
else begin
	curr <= next;
	round <= round_next;
end //end else
end //end always ff

always_comb begin //state machine
next = curr;
	 AES_DONE = 1'b0;
	 AES_MSG_DEC = 127'b0;
	 mixin = 8'b0;	
	 state = AES_MSG_ENC;
	 round_next = 4'b0;
	
	 
	 
unique case(curr)

	 
  default: ;
  
  
  start: //start initial state
  begin
  if(AES_START)
    next = expand;  
  end  
    expand:
		next = addrk0;
	addrk0:
		next = shift;
	shift:
		next = sub;
	sub:
		next = addrk;
	addrk:
	begin
		if(round==4'b1010)
			next = done;
		else
			next = mix0;
	end
	
	mix0: //begin mixcolumns/save states
		next = save0;
	save0: 
		next = mix1;
	mix1:
		next = save1;
	save1:
		next = mix2;
	mix2:
		next = save2;
	save2:
		next = mix3;
	mix3:
		next = save3;
	save3:
		next = shift;  //4 mixes and 4 saves
		
	done: //final ending state
		next = pause;
  
  pause: //checking for button holds
  begin
  if(~AES_START)
  	next = start;  
  end  
 
  endcase
 
  case(curr)
  		
	default: ;
  
  start:
	begin
	 state = AES_MSG_ENC;
	 
	end
	
  done:
  begin
	 AES_MSG_DEC = state;
	AES_DONE = 1'b1;
  end
  
  mix0:
	mixin = state[31:0];
  
  mix1:
	mixin = state[63:32];
	
  mix2:
	mixin = state[95:64];
	
  mix3:
	mixin = state[127:96];
	
	save0:
	state[31:0] = mixout;
		
	save1:
	state[63:32] = mixout;
		
	save2:
	state[95:64] = mixout;
		
	save3:
		begin
		
		state[127:96] = mixout;
		round_next  = round+1'b1;
		
		end
	
	addrk0:
		state = addout;
		
	addrk:
		state = addout;
		
	shift:
	begin
	
		state = shiftout;
	
	end
	
	sub:
		begin
		
		state[7:0] = subout[7:0];
		state[15:8] = subout[15:8];
		state[23:16] = subout[23:16];
		state[31:24] = subout[31:24];
		state[39:32] = subout[39:32];
		state[47:40] = subout[47:40];
		state[55:48] = subout[55:48];
		state[63:56] = subout[63:56];
		state[71:64] = subout[71:64];
		state[79:72] = subout[79:72];
		state[87:80] = subout[87:80];
		state[95:88] = subout[95:88];
		state[103:96] = subout[103:96];
		state[111:104] = subout[111:104];
		state[119:112] = subout[119:112];
		state[127:120] = subout[127:120];
		
		end
	
	endcase
end //end always comb

always_comb 
		begin 
			case(round)
				4'b0000:
					roundkey = key_schedule[127:0];
				4'b0001:
					roundkey = key_schedule[255:128];
				4'b0010:
					roundkey = key_schedule[383:256];
				4'b0011:
					roundkey = key_schedule[511:384];
				4'b0100:
					roundkey = key_schedule[639:512];
				4'b0101:
					roundkey = key_schedule[767:640];
				4'b0110:
					roundkey = key_schedule[895:768];
				4'b0111:
					roundkey = key_schedule[1023:896];
				4'b1000:
					roundkey = key_schedule[1151:1024];
				4'b1001:
					roundkey = key_schedule[1279:1152];
				4'b1010:
					roundkey = key_schedule[1407:1280];
				default:
					roundkey = 128'b0;
				endcase
		end

endmodule



//begin 
//byte state[4,Nb]  
//state = in  
//AddRoundKey(state, w[Nr*Nb, (Nr+1)*Nb-1])  
//for round = Nr–1 step -1 downto 1    
//InvShiftRows(state)     
//InvSubBytes(state)     
//AddRoundKey(state, w[round*Nb, (round+1)*Nb-1])     
//InvMixColumns(state)  
//end for  
//InvShiftRows(state) 
//InvSubBytes(state) 
//AddRoundKey(state, w[0, Nb-1])  
//out = state 
//end 





