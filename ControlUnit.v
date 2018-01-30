module NextStateDecoder  (output reg [6:0] NextState, input [6:0] State, input [31:0] IR, input BCond, input TCond, input MOC);
always @ (IR,State,BCond,TCond,MOC)
	case (State)
		//0
		7'b000000 : 
			NextState = 7'b0000001;

		//1
		7'b000001 : 
			NextState = 7'b0000010;

		//2
		7'b000010 : 
			NextState = 7'b0000011;

		//3
		7'b000011 : 
			if (MOC) 
				NextState = 7'b0000100; 
			else 
				NextState = 7'b0000011;

		//4
		7'b000100 : 
			begin
   				// data processing arithmetic without cc nextstate=0001010
   				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000000 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

 				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b001000 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

    				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000100 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

    				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b001100 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

   				// data processing arithmetic with cc nextstate=0001100
   				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010000 && IR[13] == 1'b0) 
					NextState = 7'b0001100;

    				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b011000 && IR[13] == 1'b0) 
					NextState = 7'b0001100;

    				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010100 && IR[13] == 1'b0) 
					NextState = 7'b0001100;

    				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b011100 && IR[13] == 1'b0)
					 NextState = 7'b0001100;

   				// data processing arithmetic without cc SIMM13 nextstate=0001011
    				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000000 && IR[13] == 1'b1) 
					NextState = 7'b0001011;

   				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b001000 && IR[13] == 1'b1) 
					NextState = 7'b0001011;

    				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000100 && IR[13] == 1'b1) 
					NextState = 7'b0001011;

    				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b001100 && IR[13] == 1'b1) 
					NextState = 7'b0001011;
	
    				// data processing arithmetic with cc SIMM13 nextstate=0001101
    				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010000 && IR[13] == 1'b1) 
					NextState = 7'b0001101;

    				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b011000 && IR[13] == 1'b1) 
					NextState = 7'b0001101;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010100 && IR[13] == 1'b1) 
					NextState = 7'b0001101;

    				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b011100 && IR[13] == 1'b1) 
					NextState = 7'b0001101;

    				// data processing logical without cc nextstate=0001010
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000001 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000101 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000010 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000110 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000011 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000111 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

				// data processing logical with cc nextstate=0001100
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010001 && IR[13] == 1'b0) 
					NextState = 7'b0001100;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010101 && IR[13] == 1'b0) 
					NextState = 7'b0001100;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010010 && IR[13] == 1'b0) 
					NextState = 7'b0001100;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010110 && IR[13] == 1'b0) 
					NextState = 7'b0001100;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010011 && IR[13] == 1'b0) 
					NextState = 7'b0001100;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010111 && IR[13] == 1'b0) 
					NextState = 7'b0001100;

    				// data processing logical without cc SIMM13 nextstate=0001011
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000001 && IR[13] == 1'b1)
					NextState = 7'b0001011;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000101 && IR[13] == 1'b1) 
					NextState = 7'b0001011;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000010 && IR[13] == 1'b1) 
					NextState = 7'b0001011;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000110 && IR[13] == 1'b1) 
					NextState = 7'b0001011;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000011 && IR[13] == 1'b1) 
					NextState = 7'b0001011;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b000111 && IR[13] == 1'b1) 
					NextState = 7'b0001011;

				// data processing logical with cc SIMM13 nextstate=0001101
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010001 && IR[13] == 1'b1) 
					NextState = 7'b0001101;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010101 && IR[13] == 1'b1) 
					NextState = 7'b0001101;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010010 && IR[13] == 1'b1) 
					NextState = 7'b0001101;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010110 && IR[13] == 1'b1) 
					NextState = 7'b0001101;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010011 && IR[13] == 1'b1) 
					NextState = 7'b0001101;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b010111 && IR[13] == 1'b1) 
					NextState = 7'b0001101;

				// data processing shift nextstate=0001010
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b100101 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b100110 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b100111 && IR[13] == 1'b0) 
					NextState = 7'b0001010;

				// data processing sethi without cc nextstate=0001110
				if (IR[31:30]== 2'b10 && IR[24:22] == 6'b100) 
					NextState = 7'b0001110;

				//load   nextstate = 0010100
				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b001001 && IR[13] == 1'b0) 
					NextState = 7'b0010100;

				if (IR[31:30]== 2'b11 &&  IR[24:19] == 6'b001010 && IR[13] == 1'b0) 
					NextState = 7'b0010100;

				if (IR[31:30]== 2'b11 &&IR[24:19] == 6'b001000 && IR[13] == 1'b0) 
					NextState = 7'b0010100;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000001 && IR[13] == 1'b0) 
					NextState = 7'b0010100;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000010 && IR[13] == 1'b0) 
					NextState = 7'b0010100;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000011 && IR[13] == 1'b0) 
					NextState = 7'b0010100;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b001101 && IR[13] == 1'b0) 
					NextState = 7'b0010100;

				//load SIMM13 nextstate = 0011110
				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b001001 && IR[13] == 1'b1) 
					NextState = 7'b0011110;

				if (IR[31:30]== 2'b11 &&  IR[24:19] == 6'b001010 && IR[13] == 1'b1) 
					NextState = 7'b0011110;

				if (IR[31:30]== 2'b11 &&IR[24:19] == 6'b001000 && IR[13] == 1'b1) 
					NextState = 7'b0011110;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000001 && IR[13] == 1'b1) 
					NextState = 7'b0011110;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000010 && IR[13] == 1'b1) 
					NextState = 7'b0011110;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000011 && IR[13] == 1'b1) 
					NextState = 7'b0011110;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b001101 && IR[13] == 1'b1) 
					NextState = 7'b0011110;

				//store nextstate=0011001
				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000110 && IR[13] == 1'b0)
					NextState = 7'b0011001;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000100 && IR[13] == 1'b0) 
					NextState = 7'b0011001;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000111 && IR[13] == 1'b0) 
					NextState = 7'b0011001;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b001111 && IR[13] == 1'b0) 
					NextState = 7'b0011001;

				//store SIMM13 nextstate=0100011
				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000110 && IR[13] == 1'b1) 
					NextState = 7'b0100011;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000101 && IR[13] == 1'b1) 
					NextState = 7'b0100011;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000100 && IR[13] == 1'b1) 
					NextState = 7'b0100011;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b000111 && IR[13] == 1'b1) 
					NextState = 7'b0100011;

				if (IR[31:30]== 2'b11 && IR[24:19] == 6'b001111 && IR[13] == 1'b1) 
					NextState = 7'b0100011;

				//call nextstate=0101000
				if (IR[31:30]== 2'b01) 
					NextState = 7'b0101000;

				//jmpl nextstate=0101010
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b111000) 
					NextState = 7'b0101010;

				//rett nextstate=0101101
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b111001 && IR[13] == 1'b0) 
					NextState = 7'b0101101;

				//rett SIMM13 nextstate=0101110
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b111001 && IR[13] == 1'b1) 
					NextState = 7'b0101110;

				//branch true nextstate=0110010
				if (IR[31:30]== 2'b00 &&  IR[28:25] == 4'b1001 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b0001 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b1010 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b0010 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b1011 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b0011 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b1100 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b0100 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b1101 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b0101 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b1110 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b0110 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b1111 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[28:25] == 4'b0111 && IR[24:22] == 3'b010 && BCond) 
					NextState = 7'b0110001;

				//cond branch false a=0 nextstate=0110011
				if (IR[31:30]== 2'b00 && IR[29] == 0 && IR[28:25] == 4'b1000 && IR[24:22] == 3'b010 && BCond==0) 
					NextState = 7'b0110011;
					
				//NEW !!!
				if (IR[31:30]== 2'b00 && IR[29] == 0 && IR[28:25] == 4'b1001 && IR[24:22] == 3'b010 && !BCond) 
					NextState = 7'b0000001;


				//cond branch false a=1 nextstate=0110100
				if (IR[31:30]== 2'b00 && IR[29] == 1 && IR[28:25] == 4'b1000 && IR[24:22] == 3'b010) 
					NextState = 7'b0110100;
				//uncond branch a=0 nextstate=0110110
				if (IR[31:30]== 2'b00 && IR[29] == 0 && IR[28:25] == 4'b1000 && IR[24:22] == 3'b010) 
					NextState = 7'b0110001;

				if (IR[31:30]== 2'b00 && IR[29] == 1 && IR[28:25] == 4'b0000 && IR[24:22] == 3'b010) 
					NextState = 7'b0110110;

				//RSR 
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b101001) 
					NextState = 7'b0111100;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b101010) 
					NextState = 7'b0111101;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b101011) 
					NextState = 7'b0111110;

				//WSR
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b110001 && IR[13] == 0) 
					NextState = 7'b0111111;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b110010 && IR[13] == 0) 
					NextState = 7'b1000001;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b110011 && IR[13] == 0) 
					NextState = 7'b1000011;
				//WSR SIMM13
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b110001 && IR[13] == 1) 
					NextState = 7'b1000000;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b110010 && IR[13] == 1) 
					NextState = 7'b1000010;

				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b110011 && IR[13] == 1) 
					NextState = 7'b1000100;

				//save CWP nextstate = 1000110
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b111100) 
					NextState = 7'b100011;

				//restore CWP nextstate = 1001001
				if (IR[31:30]== 2'b10 && IR[24:19] == 6'b111101) 
					NextState = 7'b1001001;

				//TTR nextstate=1010000
				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1000 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0000 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1001 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0001 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1010 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0010 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1011 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0011 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1100 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0100 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1101 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0101 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1110 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0110 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1111 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0111 && IR[24:19] == 6'b111010 && IR[13] == 0) 
					NextState = 7'b1010000;

				//TTR SIMM13 nextstate=1010001
				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1000 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0000 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1001 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0001 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1010 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0010 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1011 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0011 && IR[24:19] == 6'b111010 && IR[13] == 1)
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1100 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0100 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1101 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0101 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1110 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0110 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b1111 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

				if (IR[31:30]== 2'b10 && IR[28:25] == 4'b0111 && IR[24:19] == 6'b111010 && IR[13] == 1) 
					NextState = 7'b1010001;

			end
		//10
		7'b0001010: 
			NextState = 7'b0000001;
		//11
		7'b0001011: 
			NextState = 7'b0000001;
		//12
		7'b0001100: 
			NextState = 7'b0000001;
		//13
		7'b0001101: 
			NextState = 7'b0000001;
		//14
		7'b0001110: 
			NextState = 7'b0000001;

		//15
		7'b0001111: 
			NextState = 7'b0010001;

		//16
		7'b0010000: 
			NextState = 7'b0010001;

		//17
		7'b0010001:
			NextState = 7'b0010010;

		//18
		7'b0010010:
			NextState = 7'b0010011;

		//19
		7'b0010011:
			NextState = 7'b0000001;


		//20
		7'b0010100: 
			NextState = 7'b0010101;

		//30
		7'b0011110: 
			NextState = 7'b0010101;

		7'b0010101: 
			NextState = 7'b0010110; 

		7'b0010110: 
			if(MOC) 
				NextState = 7'b0010111; 
			else 
				NextState = 7'b0010110;

		7'b0010111: 
			NextState = 7'b0000001;

		7'b0011001: 
			NextState = 7'b0011010;

		7'b0100011: 
			NextState = 7'b0011010;

		7'b0011010: 
			NextState = 7'b0011011;

		7'b0011011: 
			NextState = 7'b0011100; 


		7'b0011100: 
			if(MOC) 
				NextState = 7'b0000001; 
			else 
				NextState = 7'b0011100;

		7'b0101000: 
			NextState = 7'b0101001;
		7'b0101001: 
			NextState = 7'b0000001;

		7'b0101010: 
			if(IR[13] == 0)
 				NextState = 7'b0101011; 
			else 
				NextState = 7'b0101100;

		7'b0101011: 
			NextState = 7'b0000001;

		7'b0101100: 
			NextState = 7'b0000001;

		7'b0101101: 
			NextState = 7'b0101111;

		7'b0101110: 
			NextState = 7'b0101111;
		//49
		7'b0110001:
			NextState = 7'b0110010;

		//50
		7'b0110010: 
			NextState = 7'b0000010;
			
		7'b1111111:
			NextState = 7'b0000010;


		7'b0110011: 
			NextState = 7'b0000001;

		7'b0110100: 
			NextState = 7'b0000001;

		7'b0110101: 
			NextState = 7'b0000001;

		7'b0110110: 
			NextState = 7'b0000001;

		7'b0111100: 
			NextState = 7'b0000001;

		7'b0111101: 
			NextState = 7'b0000001;

		7'b0111110: 
			NextState = 7'b0000001;

		7'b0111111: 
			NextState = 7'b0000001;

		7'b1000000: 
			NextState = 7'b0000001;

		7'b1000001: 
			NextState = 7'b0000001;

		7'b1000010: 
			NextState = 7'b0000001;

		7'b1000011: 
			NextState = 7'b0000001;

		7'b1000100: 
			NextState = 7'b0000001;

		7'b1000110: 
			if(IR[13] == 0) 
				NextState = 7'b1000111; 
			else 
				NextState = 7'b1001000;

		7'b1000111: 
			NextState = 7'b0000001;

		7'b1001000: 
			NextState = 7'b0000001;

		7'b1001001: 
			if(IR[13] == 0) 
				NextState = 7'b1001010; 
			else 
				NextState = 7'b1001011;

		7'b1001010: 
			NextState = 7'b0000001;

		7'b1001011: 
			NextState = 7'b0000001;

		7'b1010000: 
			NextState = 7'b1010010;

		7'b1010001: 
			NextState = 7'b1010010;

		7'b1010010: 
			NextState = 7'b1010011;

		7'b1010011: 
			NextState = 7'b1010100;

		7'b1010100: 
			NextState = 7'b1010101;

		7'b1010101: 
			NextState = 7'b0000001;

		default: 
			NextState = 7'b0000000;
	endcase
endmodule


module StateReg(output reg [6:0] State, input [6:0] NextState, input Clk, input Clr);
always @ (posedge Clk, negedge Clr)
if(!Clr) State <= 7'b0000000;
else State <= NextState;
endmodule


module ControlSignalEncoder(output reg reg_win_en, rf_load_en, rf_clear_en, output reg ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, npc_clr, psr_ld, r_w, mov, output reg [1:0] type, output reg fr_ld, output reg [1:0] ma, mb, output reg mc, mf, mm, mr, output reg [1:0] mnp, output reg mop, output reg [1:0] mp, output reg msa, output reg [1:0] msc, output reg [5:0] opxx, input [6:0] State);
always @ (State)
	case (State)
//0
7'b0000000: 
begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 1;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 1; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 1; mnp  = 2'b11; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//1
7'b0000001: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 1; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b10; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 2'b11; msa = 0; msc = 0; opxx = 6'b100001;
end


//2
7'b0000010: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0; ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 1; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 1; mov = 1; type = 2'b10; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp  = 2'b11; mop = 0; mp = 2'b11; msa = 0; msc = 0; opxx = 6'b000000;
end


//3
7'b0000011: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 1; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 1; mov = 1; type = 2'b10; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp  = 2'b11; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//4
7'b0000100: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp  = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//10
7'b0001010: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0;ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp  = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//11
7'b0001011: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b01; mc = 0; mf = 0; mm = 0; mr = 0; mnp  = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//12
7'b0001100: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 1; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//13
7'b0001101: begin  reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0; ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 1; ma = 0; mb = 2'b01; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//14
7'b0001110: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b10; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0; opxx = 6'b100001;
end


//15
7'b0001111: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 1; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 1; mov = 0; type = 2'b01; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//16
7'b0010000: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 1; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 1; mov = 0; type = 2'b01; fr_ld = 0; ma = 0; mb = 2'b01; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//17
7'b0010001: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 1; mov = 1; type = 2'b01; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//18
7'b0010010: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 1; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 1; mov = 1; type = 2'b01; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//19
7'b0010011: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0; ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 2'b01; fr_ld = 0; ma = 0; mb = 2'b11; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0; opxx = 6'b100001;
end


//20
7'b0010100: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 1; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 1; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//21
7'b0010101: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 1; mov = 1; type = 2'b00; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//22
7'b0010110: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 1; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 1; mov = 1; type = 2'b00; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


//23
7'b0010111: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0; ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 2'b00; fr_ld = 0; ma = 0; mb = 2'b11; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0; opxx = 6'b100001;
end


//25
7'b0011001: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 1; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 1; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 1; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end

//26
7'b0011010: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 1; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 1; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 1; msc = 0; opxx = 6'b100000;
end


7'b0011011: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 1; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0011100: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 1; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0011110: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 1; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 1; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b01; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0100011: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 1; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 1; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b01; mc = 0; mf = 0; mm = 1; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0101000: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b10; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 2'b01; opxx = 6'b100001;
end


7'b0101001: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 1; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp  = 2'b10; mop = 0; mp = 2'b11; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0101010: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b10; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0; opxx = 6'b100001;
end


7'b0101011: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 1; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 2'b11;  msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0101100: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 1; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b01; mc = 0; mf = 0; mm = 0; mr = 0; mnp  = 0; mop = 0; mp = 2'b11; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0101101: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 1; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp  = 0; mop = 0; mp = 2'b11; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0101110: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 1; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b01; mc = 0; mf = 0; mm = 0; mr = 0; mnp  = 0; mop = 0; mp = 2'b11; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0101111: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 1;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 2'b01; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp  = 0;  mop = 1; mp = 0;  msa = 0; msc = 0; opxx = 6'b100100;
end

//49
7'b0110001: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 1; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b10; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 2'b11; msa = 0; msc = 0; opxx = 6'b100001;
end


//50
7'b0110010: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 2'b00; fr_ld = 0; ma = 0; mb = 2'b00; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 2'b10; mop = 0; mp = 2'b11; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0110011: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 1; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 2'b11; mop = 0; mp = 2'b11; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0110100: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 1; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 2'b01; mop = 0; mp = 2'b10; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0110101: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 1; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 2'b10; mop = 0; mp = 2'b11; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0110110: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 1; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 2'b01; mop = 0; mp = 2'b10; msa = 0; msc = 0;  opxx = 6'b000000;
end


7'b0111100: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 2'b01; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0;  opxx = 6'b000000;
end


7'b0111101: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 2'b10; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b0111110: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 2'b11; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0;  opxx = 6'b000000;
end


7'b0111111: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 1;  r_w = 0; mov = 0; type = 0; fr_ld = 1; ma = 0; mb = 0; mc = 0; mf = 1; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b1000000: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 1;  r_w = 0; mov = 0; type = 0; fr_ld = 1; ma = 0; mb = 2'b01; mc = 0; mf = 1; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0;  opxx = 6'b000000;
end


7'b1000001: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 1; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b1000010: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 1; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b01;  mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b1000011: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 1; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b1000100: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 1; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b01; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b1000110: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 1;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 2'b01; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0; opxx = 6'b100010;
end


7'b1000111: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b1001000: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b01; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0;  opxx = 6'b000000;
end


7'b1001001: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 1;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 2'b01; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0;  opxx = 6'b100011;
end


7'b1001010: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0;  opxx = 6'b000000;
end


7'b1001011: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b01; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0;  opxx = 6'b000000;
end


7'b1010000: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 1; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma =0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0;  opxx = 6'b000000;
end


7'b1010001: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 1; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b01; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 0; mp = 0; msa = 0; msc = 0; opxx = 6'b000000;
end


7'b1010010: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 1;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 2'b01; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 0;  opxx = 6'b100101;
end


7'b1010011: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b10; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 2'b10; opxx = 6'b100001;
end


7'b1010100: begin reg_win_en = 1; rf_load_en = 1; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 0; npc_ld = 0; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 2'b10; mc = 1; mf = 0; mm = 0; mr = 0; mnp = 0; mop = 1; mp = 0; msa = 0; msc = 2'b11; opxx = 6'b100001;
end


7'b1010101: begin reg_win_en = 0; rf_load_en = 0; rf_clear_en = 0;  ir_ld = 0; mar_ld = 0; mdr_ld = 0; wim_ld = 0; tbr_ld = 0; ttr_ld = 0; pc_ld = 1; npc_ld = 1; npc_clr=0; psr_ld = 0;  r_w = 0; mov = 0; type = 0; fr_ld = 0; ma = 0; mb = 0; mc = 0; mf = 0; mm = 0; mr = 0; mnp = 2'b10; mop = 0; mp = 2'b01; msa = 0; msc = 0; opxx = 6'b000000;
end
endcase
endmodule



module ControlUnit (output [6:0] State, output reg_win_en, rf_load_en, rf_clear_en,  output ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, npc_clr, psr_ld, r_w, mov, output [1:0] type, output fr_ld, output [1:0] ma, mb, output mc, mf, mm, mr, output [1:0]mnp,output mop, output [1:0] mp,output msa, output [1:0] msc, output [5:0] opxx, input [31:0] IR, input BCond, TCond, Clk, MOC, Clr );

wire [6:0] NextState;

NextStateDecoder NSD(NextState,State,IR,BCond, TCond, MOC);

ControlSignalEncoder CSE(reg_win_en, rf_load_en, rf_clear_en, ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, npc_clr, psr_ld, r_w, mov, type, fr_ld, ma, mb, mc, mf, mm, mr, mnp, mop, mp, msa, msc, opxx, State);

StateReg SR(State,NextState,Clk,Clr);

endmodule
