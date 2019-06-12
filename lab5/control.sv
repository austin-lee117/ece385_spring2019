module control (
	input logic Clk, Reset, LoadB, Run, lsb,
	output logic Shift_En, LdB, Add, Sub, resetA
	);
	enum logic [4:0] {A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, X} curr_state, next_state;
	always_ff @ (posedge Clk or posedge Reset)
	begin
		if (Reset)
			curr_state <= A;
		else
			curr_state <= next_state;
	end
	
	always_comb
		begin
		
		next_state = curr_state;
		unique case (curr_state)
		
		A: if(Run) //start state
			next_state = B;
		//X: next_state = B;	
		B: next_state = C; //first add
		C: next_state = D; //first shift
		D: next_state = E; //add 2
		E: next_state = F; //shift 2
		F: next_state = G; //add 3
		G: next_state = H; //shift 3
		H: next_state = I; //add 4
		I: next_state = J; //shift 4
		J: next_state = K; //add 5
		K: next_state = L; //shift 5
		L: next_state = M; //add 6
		M: next_state = N; //shift 6
		N: next_state = O; //add 7
		O: next_state = P; //shift 7		
		P: next_state = Q; //add 8 (check for subtract)
		Q: next_state = R; //shift 8
		R: if(~Run) //end state
			next_state = X;
		X: next_state = A;
			
		endcase
			
		case (curr_state)
			A: //starting
			begin
				LdB = LoadB;
				resetA = 1'b1;
				Shift_En = 1'b0;
				Add = 1'b0;
				Sub = 1'b0;
			end
			X:
			begin
				LdB = 1'b0;
				resetA = 1'b0;
				Shift_En = 1'b0;
				Add = 1'b0;
				Sub = 1'b0;
			end
			
			B, D, F, H, J, L, N: //add states
			begin
			if (lsb)
			begin
				LdB = 1'b0;
				resetA = 1'b0;
				Shift_En = 1'b0;
				Add = 1'b1;
				Sub = 1'b0;
			end
			else begin
				LdB = 1'b0;
				resetA = 1'b0;
				Shift_En = 1'b0;
				Add = 1'b0;
				Sub = 1'b0;
			end
			end
			
			C, E, G, I, K, M, O, Q: //shift states
			begin
				LdB = 1'b0;
				resetA = 1'b0;
				Shift_En = 1'b1;
				Add = 1'b0;
				Sub = 1'b0;
			end
			P:
			begin
				if(lsb)
				begin
				LdB = 1'b0;
				resetA = 1'b0;
				Shift_En = 1'b0;
				Add = 1'b0;
				Sub = 1'b1; //subtract if lsb is 1
				end
				else begin //else no add needed
				LdB = 1'b0;
				resetA = 1'b0;
				Shift_En = 1'b0;
				Add = 1'b0;
				Sub = 1'b0;
				end
			end
			R:
			begin
				LdB = LoadB;
				resetA = 1'b0;
				Shift_En = 1'b0;
				Add = 1'b0;
				Sub = 1'b0;
			end
				
		endcase
		
		end
		
		
endmodule
