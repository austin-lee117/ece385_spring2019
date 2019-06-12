//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper( 	input 	reset, clk,
								input              is_ball,            // Whether current pixel belongs to ball 
								input 				is_ball2,
								input 		softreset,
								input logic showtitle,
								input [9:0] wballx, wbally, bballx, bbally, wballs, bballs, //ball values
								
								input [0:11][0:88][0:1] titletext,
								input        [9:0] DrawX, DrawY,       // Current pixel coordinates
								input logic blackwon, whitewon,
                       output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
							  output logic [9:0] wballplus, bballplus,
							  output logic [1:0] gameover
                     );
//	logic [3:0] random1, random2;	
//	logic [3:0] ran1, ran2;
//	ranNum rng1(.*, .random(random1));
//	ranNum rng2(.*, .random(random2));
//	assign ran1 = random1 % 15;
//	assign ran2 = random2 % 1;
	 
    logic [7:0] Red, Green, Blue;
	 logic is_npc, is_npc2, is_npc3, is_npc4, is_npc5, is_npc6, is_npc7, is_npc8, is_npc9, is_npcA;
	 logic npcalive, npcalive2, npcalive3, npcalive4, npcalive5, npcalive6, npcalive7, npcalive8, npcalive9, npcaliveA;
	 //assign npcalive = 1;
	
	 int ball_default;
	 assign ball_default = 10'd10;
	 int wballsize, bballsize;
	 assign wballsize = ball_default + wballplus;
	 assign bballsize = ball_default + bballplus;
	 
	 int npcDistX, npcDistY, npcSize;
    assign npcDistX = DrawX - 10'd320;
    assign npcDistY = DrawY - 10'd60;
    assign npcSize = 10'd4;
		
	 int wBallDisX1, wBallDisY1;
	 int bBallDisX1, bBallDisY1;
	 assign wBallDisX1 = wballx - 10'd320;
	 assign wBallDisY1 = wbally - 10'd60;
	 assign bBallDisX1 = bballx - 10'd320;
	 assign bBallDisY1 = bbally - 10'd60;
	 
	 
	 int npcDistX2, npcDistY2, npcSize2;
    assign npcDistX2 = DrawX - 10'd320;
    assign npcDistY2 = DrawY - 10'd450;
    assign npcSize2 = 10'd6;
	 
	 int wBallDisX2, wBallDisY2;
	 int bBallDisX2, bBallDisY2;
	 assign wBallDisX2 = wballx - 10'd320;
	 assign wBallDisY2 = wbally - 10'd450;
	 assign bBallDisX2 = bballx - 10'd320;
	 assign bBallDisY2 = bbally - 10'd450;
	 	 
	 int npcDistX3, npcDistY3, npcSize3;
    assign npcDistX3 = DrawX - 10'd160;
    assign npcDistY3 = DrawY - 10'd160;
    assign npcSize3 = 10'd6;
	 
	 int wBallDisX3, wBallDisY3;
	 int bBallDisX3, bBallDisY3;
	 assign wBallDisX3 = wballx - 10'd160;
	 assign wBallDisY3 = wbally - 10'd160;
	 assign bBallDisX3 = bballx - 10'd160;
	 assign bBallDisY3 = bbally - 10'd160;
	 
	 
	 int npcDistX4, npcDistY4, npcSize4;
    assign npcDistX4 = DrawX - 10'd500;
    assign npcDistY4 = DrawY - 10'd400;
    assign npcSize4 = 10'd12;
	 
	 int wBallDisX4, wBallDisY4;
	 int bBallDisX4, bBallDisY4;
	 assign wBallDisX4 = wballx - 10'd500;
	 assign wBallDisY4 = wbally - 10'd400;
	 assign bBallDisX4 = bballx - 10'd500;
	 assign bBallDisY4 = bbally - 10'd400;
	 
	 int npcDistX5, npcDistY5, npcSize5;
    assign npcDistX5 = DrawX - 10'd128;
    assign npcDistY5 = DrawY - 10'd487;
    assign npcSize5 = 10'd4;
	 
	 int wBallDisX5, wBallDisY5;
	 int bBallDisX5, bBallDisY5;
	 assign wBallDisX5 = wballx - 10'd128;
	 assign wBallDisY5 = wbally - 10'd487;
	 assign bBallDisX5 = bballx - 10'd128;
	 assign bBallDisY5 = bbally - 10'd487;
	 
	 int npcDistX6, npcDistY6, npcSize6;
    assign npcDistX6 = DrawX - 10'd193;
    assign npcDistY6 = DrawY - 10'd089;
    assign npcSize6 = 10'd7;
	 
	 int wBallDisX6, wBallDisY6;
	 int bBallDisX6, bBallDisY6;
	 assign wBallDisX6 = wballx - 10'd193;
	 assign wBallDisY6 = wbally - 10'd089;
	 assign bBallDisX6 = bballx - 10'd193;
	 assign bBallDisY6 = bbally - 10'd089;
	 
	 int npcDistX7, npcDistY7, npcSize7;
    assign npcDistX7 = DrawX - 10'd381;
    assign npcDistY7 = DrawY - 10'd450;
    assign npcSize7 = 10'd4;
	 
	 int wBallDisX7, wBallDisY7;
	 int bBallDisX7, bBallDisY7;
	 assign wBallDisX7 = wballx - 10'd381;
	 assign wBallDisY7 = wbally - 10'd450;
	 assign bBallDisX7 = bballx - 10'd381;
	 assign bBallDisY7 = bbally - 10'd450;
	 
	 int npcDistX8, npcDistY8, npcSize8;
    assign npcDistX8 = DrawX - 10'd180;
    assign npcDistY8 = DrawY - 10'd120;
    assign npcSize8 = 10'd20;
	 
	 int wBallDisX8, wBallDisY8;
	 int bBallDisX8, bBallDisY8;
	 assign wBallDisX8 = wballx - 10'd180;
	 assign wBallDisY8 = wbally - 10'd120;
	 assign bBallDisX8 = bballx - 10'd180;
	 assign bBallDisY8 = bbally - 10'd120;
	 
	 int npcDistX9, npcDistY9, npcSize9;
    assign npcDistX9 = DrawX - 10'd480;
    assign npcDistY9 = DrawY - 10'd200;
    assign npcSize9 = 10'd8;
	 
	 int wBallDisX9, wBallDisY9;
	 int bBallDisX9, bBallDisY9;
	 assign wBallDisX9 = wballx - 10'd480;
	 assign wBallDisY9 = wbally - 10'd200;
	 assign bBallDisX9 = bballx - 10'd480;
	 assign bBallDisY9 = bbally - 10'd200;
	 
	 int npcDistXA, npcDistYA, npcSizeA;
    assign npcDistXA = DrawX - 10'd500;
    assign npcDistYA = DrawY - 10'd300;
    assign npcSizeA = 10'd4;
	 
	 int wBallDisXA, wBallDisYA;
	 int bBallDisXA, bBallDisYA;
	 assign wBallDisXA = wballx - 10'd500;
	 assign wBallDisYA = wbally - 10'd300;
	 assign bBallDisXA = bballx - 10'd500;
	 assign bBallDisYA = bbally - 10'd300;
	 
	 
	 int playerDisX, playerDisY;
  assign playerDisX = wballx - bballx;
  assign playerDisY = wbally - bbally;
	 
	 
	 
 always_ff @(posedge clk) //this is collision between white ball and the first npc, the blue one
			//if the wball position is within the npc radius size, then the npcalive gets set to 0, else it stays at 1. 
			//probably need a if(reset) set  npcalive = 1;
    begin
     if (reset)
       begin
       npcalive <= 1'b1;
       npcalive2 <= 1'b1;
		 npcalive3 <= 1'b1;
		 npcalive4 <= 1'b1;
		 npcalive5 <= 1'b1;
		 npcalive6 <= 1'b1;
		 npcalive7 <= 1'b1;
		 npcalive8 <= 1'b1;
		 npcalive9 <= 1'b1;
		 npcaliveA <= 1'b1;

       wballplus <= 10'd0;
		 bballplus <= 10'd0;
		 //gameover <= 2'b00;
       end
		 
		 else if(softreset)
		 begin
		 npcalive <= 1'b1;
       npcalive2 <= 1'b1;
		 npcalive3 <= 1'b1;
		 npcalive4 <= 1'b1;
		 npcalive5 <= 1'b1;
		 npcalive6 <= 1'b1;
		 npcalive7 <= 1'b1;
		 npcalive8 <= 1'b1;
		 npcalive9 <= 1'b1;
		 npcaliveA <= 1'b1;

       wballplus <= 10'd0;
		 bballplus <= 10'd0;
		 end
		 
     			else 
     begin	
				//NPC collisions all based on PLAYER BALL SIZE to ensure perfect overlap
				
				 if (((wBallDisX1*wBallDisX1 + wBallDisY1*wBallDisY1) <= (wballsize*wballsize)) &&(npcalive) &&(wballsize > npcSize))
					begin
					npcalive <= 0;
					wballplus <= wballplus + npcSize;
					end
				 if (((bBallDisX1*bBallDisX1 + bBallDisY1*bBallDisY1) <= (bballsize*bballsize)) && (npcalive)&&(bballsize > npcSize))
					begin
					npcalive <= 0;
					bballplus <= bballplus + npcSize;
					end
				//green ball collision (npc2)
				 if (((wBallDisX2*wBallDisX2 + wBallDisY2*wBallDisY2) <= (wballsize*wballsize)) && (npcalive2)&&(wballsize > npcSize2))
					begin
					npcalive2 <= 0;
					wballplus <= wballplus + npcSize2;
					end
				 if (((bBallDisX2*bBallDisX2 + bBallDisY2*bBallDisY2) <= (bballsize*bballsize)) && (npcalive2)&&(bballsize > npcSize2))
					begin
					npcalive2 <= 0;
					bballplus <= bballplus + npcSize2;
					end
				//npc3
				if (((wBallDisX3*wBallDisX3 + wBallDisY3*wBallDisY3) <= (wballsize*wballsize)) && (npcalive3)&&(wballsize > npcSize3))
					begin
					npcalive3 <= 0;
					wballplus <= wballplus + npcSize3;
					end
				 if (((bBallDisX3*bBallDisX3 + bBallDisY3*bBallDisY3) <= (bballsize*bballsize)) && (npcalive3)&&(bballsize > npcSize3))
					begin
					npcalive3 <= 0;
					bballplus <= bballplus + npcSize3;
					end
				//npc4
				if (((wBallDisX4*wBallDisX4 + wBallDisY4*wBallDisY4) <= (wballsize*wballsize)) && (npcalive4)&&(wballsize > npcSize4))
					begin
					npcalive4 <= 0;
					wballplus <= wballplus + npcSize4;
					end
				 if (((bBallDisX4*bBallDisX4 + bBallDisY4*bBallDisY4) <= (bballsize*bballsize)) && (npcalive4)&&(bballsize > npcSize4))
					begin
					npcalive4 <= 0;
					bballplus <= bballplus + npcSize4;
					end
				//npc5
				if (((wBallDisX5*wBallDisX5 + wBallDisY5*wBallDisY5) <= (wballsize*wballsize)) && (npcalive5)&&(wballsize > npcSize5))
					begin
					npcalive5 <= 0;
					wballplus <= wballplus + npcSize5;
					end
				 if (((bBallDisX5*bBallDisX5 + bBallDisY5*bBallDisY5) <= (bballsize*bballsize)) && (npcalive5)&&(bballsize > npcSize5))
					begin
					npcalive5 <= 0;
					bballplus <= bballplus + npcSize5;
					end
				//npc6
				if (((wBallDisX6*wBallDisX6 + wBallDisY6*wBallDisY6) <= (wballsize*wballsize)) && (npcalive6)&&(wballsize > npcSize6))
					begin
					npcalive6 <= 0;
					wballplus <= wballplus + npcSize6;
					end
				 if (((bBallDisX6*bBallDisX6 + bBallDisY6*bBallDisY6) <= (bballsize*bballsize)) && (npcalive6)&&(bballsize > npcSize6))
					begin
					npcalive6 <= 0;
					bballplus <= bballplus + npcSize6;
					end
				//npc7
				if (((wBallDisX7*wBallDisX7 + wBallDisY7*wBallDisY7) <= (wballsize*wballsize)) && (npcalive7)&&(wballsize > npcSize7))
					begin
					npcalive7 <= 0;
					wballplus <= wballplus + npcSize7;
					end
				 if (((bBallDisX7*bBallDisX7 + bBallDisY7*bBallDisY7) <= (bballsize*bballsize)) && (npcalive7)&&(bballsize > npcSize7))
					begin
					npcalive7 <= 0;
					bballplus <= bballplus + npcSize7;
					end
				//npc8
				if (((wBallDisX8*wBallDisX8 + wBallDisY8*wBallDisY8) <= (wballsize*wballsize)) && (npcalive8)&&(wballsize > npcSize8))
					begin
					npcalive8 <= 0;
					wballplus <= wballplus + npcSize8;
					end
				 if (((bBallDisX8*bBallDisX8 + bBallDisY8*bBallDisY8) <= (bballsize*bballsize)) && (npcalive8)&&(bballsize > npcSize8))
					begin
					npcalive8 <= 0;
					bballplus <= bballplus + npcSize8;
					end
				//npc9
				if (((wBallDisX9*wBallDisX9 + wBallDisY9*wBallDisY9) <= (wballsize*wballsize)) && (npcalive9)&&(wballsize > npcSize9))
					begin
					npcalive9 <= 0;
					wballplus <= wballplus + npcSize9;
					end
				 if (((bBallDisX9*bBallDisX9 + bBallDisY9*bBallDisY9) <= (bballsize*bballsize)) && (npcalive9)&&(bballsize > npcSize9))
					begin
					npcalive9 <= 0;
					bballplus <= bballplus + npcSize9;
					end
				//npcA
				if (((wBallDisXA*wBallDisXA + wBallDisYA*wBallDisYA) <= (wballsize*wballsize)) && (npcaliveA)&&(wballsize > npcSizeA))
					begin
					npcaliveA <= 0;
					wballplus <= wballplus + npcSizeA;
					end
				 if (((bBallDisXA*bBallDisXA + bBallDisYA*bBallDisYA) <= (bballsize*bballsize)) && (npcaliveA)&&(bballsize > npcSizeA))
					begin
					npcaliveA <= 0;
					bballplus <= bballplus + npcSizeA;
					end
				
    end
    end
	 
	 //checking for player to player collisions, using both black ball's size AND white ball's size to detect overlap
	 
	 always_comb begin
	 if ((playerDisX * playerDisX) + (playerDisY * playerDisY) <= ((bballsize*bballsize)||(wballsize*wballsize)) && (wballsize > bballsize)) //checking if the player balls are within a radius of each other
				
					 gameover = 2'b01;
	else if ((playerDisX * playerDisX) + (playerDisY * playerDisY) <= ((bballsize*bballsize)||(wballsize*wballsize)) && (bballsize > wballsize))
					gameover = 2'b10;
					
	else gameover = 2'b00;
					 
		

   end
	
		
//	always_comb begin
//	 if ((playerDisX * playerDisX) + (playerDisY * playerDisY) <= bballsize && (bballsize > wballsize)) //checking if the player balls are within a radius of each other
//				
//					 gameover = 2'b10;
//	else gameover = 2'b00;
//					 
//		
//
//   end
	 

	 
	 
	 
	  always_comb begin
        if ( ( npcDistX*npcDistX + npcDistY*npcDistY) <= (npcSize*npcSize)  && npcalive)
		
            is_npc = 1'b1;
		
        else
            is_npc = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end

	 
	  always_comb begin
        if ( ( npcDistX2*npcDistX2 + npcDistY2*npcDistY2) <= (npcSize2*npcSize2) && npcalive2)
			
            is_npc2 = 1'b1;
		
        else
            is_npc2 = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 
	 	 
	  always_comb begin
        if ( ( npcDistX3*npcDistX3 + npcDistY3*npcDistY3) <= (npcSize3*npcSize3) && npcalive3)
			
            is_npc3 = 1'b1;
		
        else
            is_npc3 = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 always_comb begin
        if ( ( npcDistX4*npcDistX4 + npcDistY4*npcDistY4) <= (npcSize4*npcSize4) && npcalive4)
			
            is_npc4 = 1'b1;
		
        else
            is_npc4 = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 always_comb begin
        if ( ( npcDistX5*npcDistX5 + npcDistY5*npcDistY5) <= (npcSize5*npcSize5) && npcalive5)
			
            is_npc5 = 1'b1;
		
        else
            is_npc5 = 1'b0;
        /* The ball's (pixelted) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 always_comb begin
        if ( ( npcDistX6*npcDistX6 + npcDistY6*npcDistY6) <= (npcSize6*npcSize6) && npcalive6)
			
            is_npc6 = 1'b1;
		
        else
            is_npc6 = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 always_comb begin
        if ( ( npcDistX7*npcDistX7 + npcDistY7*npcDistY7) <= (npcSize7*npcSize7) && npcalive7)
			
            is_npc7 = 1'b1;
		
        else
            is_npc7 = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 always_comb begin
        if ( ( npcDistX8*npcDistX8 + npcDistY8*npcDistY8) <= (npcSize8*npcSize8) && npcalive8)
			
            is_npc8 = 1'b1;
		
        else
            is_npc8 = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 always_comb begin
        if ( ( npcDistX9*npcDistX9 + npcDistY9*npcDistY9) <= (npcSize9*npcSize9) && npcalive9)
			
            is_npc9 = 1'b1;
		
        else
            is_npc9 = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 always_comb begin
        if ( ( npcDistXA*npcDistXA + npcDistYA*npcDistYA) <= (npcSizeA*npcSizeA) && npcaliveA)
			
            is_npcA = 1'b1;
		
        else
            is_npcA = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 
	 
	 always_comb begin
       if((showtitle)&&(DrawX>=10'd550)&&(DrawX<=10'd639)&&(DrawY>=10'd465)&&(DrawY<=10'd479))
			asdf = titletext[DrawY-10'd465][DrawX-10'd550];
			else
			asdf = 1'b0;
    end
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
	 logic asdf;
	 
	 
    // Assign color based on is_ball signal
    always_comb
    begin
	 
			if(blackwon)
				begin
				Red = 8'h00;
				Green = 8'h00;
				Blue = 8'h00;
				end
			else if(whitewon)
				begin
				Red = 8'hff;
				Green = 8'hff;
				Blue = 8'hff;
				end
        else if (is_ball == 1'b1) 
        begin
            // White ball
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
        end
		  else if(is_ball2 == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'h00;
		  end
		  else if(is_npc == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
		  end
		  else if(is_npc2 == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'hff;
            Blue = 8'h00;
		  end
		   else if(is_npc3 == 1'b1)
		  begin
				Red = 8'h88;
            Green = 8'h00;
            Blue = 8'h88;
		  end
		   else if(is_npc4 == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
		  end
		   else if(is_npc5 == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'hff;
            Blue = 8'h00;
		  end
		   else if(is_npc6 == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
		  end
		   else if(is_npc7 == 1'b1)
		  begin
				Red = 8'h88;
            Green = 8'h00;
            Blue = 8'h88;
		  end
		   else if(is_npc8 == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'h00;
            Blue = 8'hff;
		  end
		   else if(is_npc9 == 1'b1)
		  begin
				Red = 8'h44;
            Green = 8'h44;
            Blue = 8'h44;
		  end
		   else if(is_npcA == 1'b1)
		  begin
				Red = 8'h00;
            Green = 8'hff;
            Blue = 8'h00;
		  end
		  else if(asdf ==1'b1)
		  begin
				Red = 8'hff;
            Green = 8'h00;
            Blue = 8'hff;
		  
		  end
		  
        else 
        begin
            // Background with nice color gradient
            Red = 8'h3f; 
            Green = 8'h00;
            Blue = 8'h00;
        end
    end 
	 
endmodule



//
//module ranNum(input clk, reset, output [3:0]random);
//	logic [3:0] data;
//   logic feedback = data[4] ^ data[1];
//       always_ff @ (posedge clk)
//         if (reset)
//           data <= 4'hABCD;
//       		else
//            data <= {data[2:0], feedback};
//       
//endmodule

