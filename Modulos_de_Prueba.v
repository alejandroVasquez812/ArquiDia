*
  TestBench for Register Windows Module
*/
module Test_Register_Windows;

//Inputs
reg [31:0] PortC;
reg [4:0] Sa, Sb, Load_Select, Clear_Select;
reg [1:0] Cwp;
reg RF_Load_Enable, RF_Clear_Enable, Register_Windows_Enable, Clk;

//Outputs
wire [31:0] PortA, PortB;

parameter sim_time = 5000;

Register_Windows myRW(PortA, PortB, PortC, Sa, Sb, Load_Select, Clear_Select, Cwp,
			RF_Load_Enable, RF_Clear_Enable, Register_Windows_Enable, Clk);

initial #sim_time $finish;

//Clock Setup
initial begin
        Clk = 1'b0;
        forever #5 Clk = ~Clk;
end



//Set default initial values as desired
initial fork

	RF_Load_Enable <= 1'b1;
	RF_Clear_Enable <= 1'b0;
	Register_Windows_Enable <= 1'b1;
	Cwp <= 2'b11;	//Begin at Window 3
	
	Load_Select <= 5'b00000;
	Clear_Select <= 5'b00000;

        PortC <= 32'h00000000;

	Sa <= 5'b00000;
	Sb <= 5'b00000;	

join


/*Uncomment this block to test Global Registers (R0 - R7)
initial begin     
	repeat(7)begin
		 #10 PortC = PortC + 32'h00000001;
		  Load_Select = Load_Select + 5'b00001;
		  Sa = Sa + 5'b00001;
		  Sb = Sb + 5'b00001;
	end
end      
*/



/*Uncomment to test overlapping register values within a Register Set
initial begin

	//Current Example: Set24 { R24_W3, R8_W2, R32_W1, R48_W0 }
	Load_Select <= 5'b01100;
	Sa <= 5'b01100;
	Sb <= 5'b01100;

	repeat(4) begin
		#10 PortC = PortC + 32'h00000001;
		Cwp = Cwp + 2'b01; //Window Order 3, 0, 1, 2
	end
	
	RF_Load_Enable = 1'b0; //Disable Loading in order to see the different outputs
	Register_Windows_Enable = 1'b0;

	repeat(4) #10 Cwp = Cwp + 2'b01;
end
*/



///*Tests all (4) windows sequentially and loop around (Round Robin) (A lot of Output!!!)
initial begin
	repeat(5) begin
		 Load_Select <= 5'b01000;
       		 PortC <= 32'h00000008;

       		 Sa <= 5'b01000;
       		 Sb <= 5'b01000; 
		repeat(24) begin
			#10 PortC = PortC + 32'h00000001;
			Load_Select = Load_Select + 5'b00001;
			Sa = Sa + 5'b00001;
			Sb = Sb + 5'b00001;
		end
		Cwp = Cwp - 2'b01; //Window Order 3, 2, 1, 0
	end

	// NOTE: Crowded output, but Round Robin functionality and 
	// preserved register values are succesfully shown here.
	
end
//*/




/*
 * The display statements used for PortA and PortB were separated
 * to reduce the amount of output that prints on onscreen.
*/

///*Display block used for PortA Debugging
initial begin
        $display("PortC          Load_Select    Cwp    Sa		PortA			Time");
        $monitor("%h       %b          %b     %b      %h	 %d ", PortC, Load_Select, Cwp, Sa, PortA, $time);
end
//*/



/*Display block used for PortB Debugging
initial begin
        $display("PortC          Load_Select   Cwp     Sb       	 PortB                   Time");
        $monitor("%h       %b          %b     %b      %h         %d ", PortC, Load_Select, Cwp, Sb, PortB, $time);
end
*/

endmodule





module TestFR;

//Inputs
reg C,N,V,Z, Clk, Le;

//Outputs
wire[3:0] Q;

FlagRegister myFR(Q, {C, N, V, Z}, Clk, Le);

initial begin
        Clk = 1'b0;
        forever #5 Clk = ~Clk;
end

initial fork
	Le =1'b1;
	C = 1'b1;
	N = 1'b1;
	V = 1'b0;
	Z = 1'b1;
join

initial begin
	#10 C = 1'b0;
	#15 V = 1'b1;
end

initial begin
        $display("Q	C N V Z		Time");
        $monitor("%b	%b %b %b %b	%d", Q, C, N, V, Z, $time);
end

endmodule



// Condition tester
module TestCondition;

//Inputs
reg[6:0] IR31_25;
reg C,N,V,Z;
reg [11:0] PSR;
reg [3:0] WIM;

//Outputs
wire BCOND, TCOND;

Condition_Tester myConditionTester(BCOND, TCOND, IR31_25,WIM,PSR, C, N, V, Z);

initial fork
	C = 1'b1;
	N = 1'b1;
	V = 1'b0;
	Z = 1'b1;
	IR31_25[6:0] = 7'b0000000;
join

initial begin
	repeat(15) begin
		#2 IR31_25 = IR31_25 + 1'b1;
	end
end

initial begin
        $display("IR31_25		BCOND	TCOND	C N V Z		Time");
        $monitor("%b		%b	%b	%b %b %b %b	%d", IR31_25, BCOND, TCOND, C, N, V, Z, $time);
end

endmodule

// ALU Test
module test_alu;
reg [5:0]op;
reg [31:0]A;
reg [31:0]B;
reg Ci;
wire [31:0]Y;
wire N,Z,C,V;
alu alu1(Y, N, Z, C, V, op, A, B, Ci);
initial #500 $finish;
initial fork
A = 32'b00000000000000000000000000001000;
B = 32'b00000000000000000000000000000111;
Ci=1;
//Operations that not modify the condition codes
op = 6'b000000;       //add 
#10 op = 6'b001000;   //addx
#20 op = 6'b000100;   //sub
#30 op = 6'b001100;   // subx
#40 op = 6'b000001;   //and
#50 op = 6'b000101;   //andn
#60 op = 6'b000010;   //or
#70 op = 6'b000110;   //orn
#80 op = 6'b000011;   //xor
#90 op = 6'b000111;   //xorn
#100 op = 6'b100101;  //sll
#110 op = 6'b100110;  // srl
#120 op = 6'b100111;  // sra
//Operations that modify the condition codes
#130 op = 6'b010000; //addcc
#140 op = 6'b011000; //addxcc
#150 op = 6'b010100; //subcc
#160 op = 6'b011100; //subxcc
#170 op = 6'b010001; //andcc
#180 op = 6'b010101; //andncc
#190 op = 6'b010010; //orcc
#200 op = 6'b010110; //orncc
#210 op = 6'b010011; //xorcc
#220 op = 6'b010111; //xorncc
#330 op = 6'b100000; //Y=A
#340 op = 6'b100001; //Y=B
#350 op = 6'b100010; // Y={A[31:5],A[4:0]-1}
#360 op = 6'b100011; //Y={A[31:5],A[4:0]+1}
#370 op = 6'b100100; //Y={A[31:8],A[6],A[6],1'b1,A[4:0]+1'b1};
#380 op = 6'b011111; //Y={A[31:8],1'b1,A[7],1'b0,A[4:0]-1'b1};
join
initial begin
$display(" A = %b ", A);
$display(" B = %b ", B);
$display(" Ci = %b ", Ci);
$display (" C N Z V Y ");
$monitor (" %b %b %b %b %b ", C, N, Z, V, Y);
end
endmodule

//Control Unit Test
module main;
reg [31:0] IR;
reg Cond;
reg Clk;
reg MOC;
reg Clr;
wire [6:0] State;
wire reg_win_en, rf_load_en, rf_clear_en, ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, npc_clr, psr_ld, r_w, mov, fr_ld, mc, mf, mm, mop, msa;
wire [4:0] clear_select;
wire [1:0] msc, type, ma, mb, mnp, mp;
wire [5:0] opxx;
ControlUnit CU(State,reg_win_en, rf_load_en, rf_clear_en, clear_select, ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, npc_clr, psr_ld, r_w, mov, type, fr_ld, ma, mb, mc, mf, mm, mnp, mop, mp, msa, msc, opxx, IR, Cond, Clk, MOC, Clr);
initial #10000 $finish;
initial begin

