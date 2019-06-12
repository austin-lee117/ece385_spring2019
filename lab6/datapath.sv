module datapath
			(input logic Reset, Clk, 
			input logic ld_ir,  ld_mdr, ld_mar, ld_pc, ld_regF, ld_cc, ld_ben, ld_led,
			input logic [15:0] mdrin,
			input logic marS, pcS, aluS, mdrS, drmS, sr1mS, sr2mS, addr1mS,
			input logic mioen,
			input logic[1:0] pcmS, addr2mS, aluSelect,
			output logic ben,
			output logic[11:0] led,
			output logic[15:0] irout, mdrout, marout,
			output logic[15:0] pc);
			
						
						
			logic[15:0] bus;
			logic[15:0] mdrmuxout, pcmuxout, sr2muxout;
			
			logic[15:0] aluout, aduout;
			logic[15:0] sr1out, sr2out;
			logic[15:0] addr1muxout, addr2muxout;
			logic[15:0] sext6, sext9, sext11, sext5;
			logic[2:0] dr, sr1, sr2;
			logic nin, zin, pin, nout, zout, pout;
			
			
			logic[15:0] pcplusone;
			
			assign pcplusone = pc+1'h01;
			assign sr2 = irout[2:0];
			
			
			fivesext sextFIVE(.IN(irout[4:0]), .OUT(sext5));
			
			sixsext sextSIX(.IN(irout[5:0]), .OUT(sext6));
			
			ninesext sextNINE(.IN(irout[8:0]), .OUT(sext9));
			
			elevensext sextELEVEN(.IN(irout[10:0]), .OUT(sext11));
	
			
			ALU addralu(.A(addr1muxout), .B(addr2muxout), .select(2'b00), .OUT(aduout));
			
			ALU alu(.A(sr1out), .B(sr2muxout), .select(aluSelect), .OUT(aluout));
			
			
			reg_16 reg_IR(.Clk(Clk), .Load(ld_ir), .Reset(Reset), .IN(bus), .OUT(irout));
			
			reg_16 reg_MDR(.Clk(Clk), .Load(ld_mdr), .Reset(Reset), .IN(mdrmuxout), .OUT(mdrout));
			
			reg_16 reg_MAR(.Clk(Clk), .Load(ld_mar), .Reset(Reset), .IN(bus), .OUT(marout)); //changed pc to bus (IN)
			
			reg_16 reg_pc(.Clk(Clk), .Load(ld_pc), .Reset(Reset), .IN(pcmuxout), .OUT(pc));
		
			regFile reg_regFile(.bus(bus), .dr(dr), .sr1(sr1), .sr2(sr2), .Clk(Clk), .Load(ld_regF), .Reset(Reset), .sr1out(sr1out), .sr2out(sr2out));
			
			
			busMUX busMUX(.select({marS, pcS, aluS, mdrS}), .mar(aduout), .pc(pc), .alu(aluout), .mdr(mdrout), .OUT(bus));
			
			MDR_MUX mdrMUX(.bus(bus), .mem(mdrin), .select(mioen), .OUT(mdrmuxout));
			
			PC_MUX pcMUX(.bus(bus), .adu(aduout), .oldpc(pcplusone), .select(pcmS), .OUT(pcmuxout));
			
			DR_MUX drMUX(.ir(irout[11:9]), .select(drmS), .OUT(dr));
			
			SR1_MUX sr1MUX(.ir1(irout[11:9]), .ir2(irout[8:6]), .select(sr1mS), .OUT(sr1));
			
			SR2_MUX sr2MUX(.regf(sr2out), .ir(sext11), .select(sr2mS), .OUT(sr2muxout));
			
			ADDR1_MUX addr1MUX(.pc(pc), .sr1(sr1out), .select(addr1mS), .OUT(addr1muxout));
			
			ADDR2_MUX addr2MUX(.sixsext(sext6), .ninesext(sext9), .elevensext(sext11), .select(addr2mS), .OUT(addr2muxout));
			
			
			NZP nzp(.Clk(Clk), .Nin(nin), .Zin(zin), .Pin(pin), .LD_CC(ld_cc), .Nout(nout), .Zout(zout), .Pout(pout));
			
			branchenable nzpenable(.Clk(Clk), .Nin(nout), .Zin(zout), .Pin(pout), .LD_BEN(ld_ben), .IN(irout[11:9]), .BEN(ben));
			
			
			always_comb
			begin //nzp logic 
			if (bus[15])
				begin
				nin = 1'b1;
				zin = 1'b0;
				pin = 1'b0;
				end
				else
				begin
				case(bus)
				16'h0: begin
						nin=1'b0;
						zin=1'b1;
						pin=1'b0;
						end
						default:
						begin
						nin=1'b0;
						zin=1'b0;
						pin=1'b1;
						end
				endcase
				end
			end
			
			always_ff @ (posedge Clk)
			begin
			if(ld_led)
				led<=irout[11:0];
				else
				led<=12'h0;
				end
				
			
			
			
			endmodule
			