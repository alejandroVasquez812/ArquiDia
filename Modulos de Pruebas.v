{\rtf1\ansi\ansicpg1252\cocoartf1561\cocoasubrtf200
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 *\
  TestBench for Register Windows Module\
*/\
module Test_Register_Windows;\
\
//Inputs\
reg [31:0] PortC;\
reg [4:0] Sa, Sb, Load_Select, Clear_Select;\
reg [1:0] Cwp;\
reg RF_Load_Enable, RF_Clear_Enable, Register_Windows_Enable, Clk;\
\
//Outputs\
wire [31:0] PortA, PortB;\
\
parameter sim_time = 5000;\
\
Register_Windows myRW(PortA, PortB, PortC, Sa, Sb, Load_Select, Clear_Select, Cwp,\
			RF_Load_Enable, RF_Clear_Enable, Register_Windows_Enable, Clk);\
\
initial #sim_time $finish;\
\
//Clock Setup\
initial begin\
        Clk = 1'b0;\
        forever #5 Clk = ~Clk;\
end\
\
\
\
//Set default initial values as desired\
initial fork\
\
	RF_Load_Enable <= 1'b1;\
	RF_Clear_Enable <= 1'b0;\
	Register_Windows_Enable <= 1'b1;\
	Cwp <= 2'b11;	//Begin at Window 3\
	\
	Load_Select <= 5'b00000;\
	Clear_Select <= 5'b00000;\
\
        PortC <= 32'h00000000;\
\
	Sa <= 5'b00000;\
	Sb <= 5'b00000;	\
\
join\
\
\
/*Uncomment this block to test Global Registers (R0 - R7)\
initial begin     \
	repeat(7)begin\
		 #10 PortC = PortC + 32'h00000001;\
		  Load_Select = Load_Select + 5'b00001;\
		  Sa = Sa + 5'b00001;\
		  Sb = Sb + 5'b00001;\
	end\
end      \
*/\
\
\
\
/*Uncomment to test overlapping register values within a Register Set\
initial begin\
\
	//Current Example: Set24 \{ R24_W3, R8_W2, R32_W1, R48_W0 \}\
	Load_Select <= 5'b01100;\
	Sa <= 5'b01100;\
	Sb <= 5'b01100;\
\
	repeat(4) begin\
		#10 PortC = PortC + 32'h00000001;\
		Cwp = Cwp + 2'b01; //Window Order 3, 0, 1, 2\
	end\
	\
	RF_Load_Enable = 1'b0; //Disable Loading in order to see the different outputs\
	Register_Windows_Enable = 1'b0;\
\
	repeat(4) #10 Cwp = Cwp + 2'b01;\
end\
*/\
\
\
\
///*Tests all (4) windows sequentially and loop around (Round Robin) (A lot of Output!!!)\
initial begin\
	repeat(5) begin\
		 Load_Select <= 5'b01000;\
       		 PortC <= 32'h00000008;\
\
       		 Sa <= 5'b01000;\
       		 Sb <= 5'b01000; \
		repeat(24) begin\
			#10 PortC = PortC + 32'h00000001;\
			Load_Select = Load_Select + 5'b00001;\
			Sa = Sa + 5'b00001;\
			Sb = Sb + 5'b00001;\
		end\
		Cwp = Cwp - 2'b01; //Window Order 3, 2, 1, 0\
	end\
\
	// NOTE: Crowded output, but Round Robin functionality and \
	// preserved register values are succesfully shown here.\
	\
end\
//*/\
\
\
\
\
/*\
 * The display statements used for PortA and PortB were separated\
 * to reduce the amount of output that prints on onscreen.\
*/\
\
///*Display block used for PortA Debugging\
initial begin\
        $display("PortC          Load_Select    Cwp    Sa		PortA			Time");\
        $monitor("%h       %b          %b     %b      %h	 %d ", PortC, Load_Select, Cwp, Sa, PortA, $time);\
end\
//*/\
\
\
\
/*Display block used for PortB Debugging\
initial begin\
        $display("PortC          Load_Select   Cwp     Sb       	 PortB                   Time");\
        $monitor("%h       %b          %b     %b      %h         %d ", PortC, Load_Select, Cwp, Sb, PortB, $time);\
end\
*/\
\
endmodule\
\
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0
\cf0 \
\
\
\
module TestFR;\
\
//Inputs\
reg C,N,V,Z, Clk, Le;\
\
//Outputs\
wire[3:0] Q;\
\
FlagRegister myFR(Q, \{C, N, V, Z\}, Clk, Le);\
\
initial begin\
        Clk = 1'b0;\
        forever #5 Clk = ~Clk;\
end\
\
initial fork\
	Le =1'b1;\
	C = 1'b1;\
	N = 1'b1;\
	V = 1'b0;\
	Z = 1'b1;\
join\
\
initial begin\
	#10 C = 1'b0;\
	#15 V = 1'b1;\
end\
\
initial begin\
        $display("Q	C N V Z		Time");\
        $monitor("%b	%b %b %b %b	%d", Q, C, N, V, Z, $time);\
end\
\
endmodule\
\
\
\
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0
\cf0 // Condition tester\
module TestCondition;\
\
//Inputs\
reg[6:0] IR31_25;\
reg C,N,V,Z;\
reg [11:0] PSR;\
reg [3:0] WIM;\
\
//Outputs\
wire BCOND, TCOND;\
\
Condition_Tester myConditionTester(BCOND, TCOND, IR31_25,WIM,PSR, C, N, V, Z);\
\
initial fork\
	C = 1'b1;\
	N = 1'b1;\
	V = 1'b0;\
	Z = 1'b1;\
	IR31_25[6:0] = 7'b0000000;\
join\
\
initial begin\
	repeat(15) begin\
		#2 IR31_25 = IR31_25 + 1'b1;\
	end\
end\
\
initial begin\
        $display("IR31_25		BCOND	TCOND	C N V Z		Time");\
        $monitor("%b		%b	%b	%b %b %b %b	%d", IR31_25, BCOND, TCOND, C, N, V, Z, $time);\
end\
\
endmodule\
\
// ALU Test\
module test_alu;\
reg [5:0]op;\
reg [31:0]A;\
reg [31:0]B;\
reg Ci;\
wire [31:0]Y;\
wire N,Z,C,V;\
alu alu1(Y, N, Z, C, V, op, A, B, Ci);\
initial #500 $finish;\
initial fork\
A = 32'b00000000000000000000000000001000;\
B = 32'b00000000000000000000000000000111;\
Ci=1;\
//Operations that not modify the condition codes\
op = 6'b000000;       //add \
#10 op = 6'b001000;   //addx\
#20 op = 6'b000100;   //sub\
#30 op = 6'b001100;   // subx\
#40 op = 6'b000001;   //and\
#50 op = 6'b000101;   //andn\
#60 op = 6'b000010;   //or\
#70 op = 6'b000110;   //orn\
#80 op = 6'b000011;   //xor\
#90 op = 6'b000111;   //xorn\
#100 op = 6'b100101;  //sll\
#110 op = 6'b100110;  // srl\
#120 op = 6'b100111;  // sra\
//Operations that modify the condition codes\
#130 op = 6'b010000; //addcc\
#140 op = 6'b011000; //addxcc\
#150 op = 6'b010100; //subcc\
#160 op = 6'b011100; //subxcc\
#170 op = 6'b010001; //andcc\
#180 op = 6'b010101; //andncc\
#190 op = 6'b010010; //orcc\
#200 op = 6'b010110; //orncc\
#210 op = 6'b010011; //xorcc\
#220 op = 6'b010111; //xorncc\
#330 op = 6'b100000; //Y=A\
#340 op = 6'b100001; //Y=B\
#350 op = 6'b100010; // Y=\{A[31:5],A[4:0]-1\}\
#360 op = 6'b100011; //Y=\{A[31:5],A[4:0]+1\}\
#370 op = 6'b100100; //Y=\{A[31:8],A[6],A[6],1'b1,A[4:0]+1'b1\};\
#380 op = 6'b011111; //Y=\{A[31:8],1'b1,A[7],1'b0,A[4:0]-1'b1\};\
join\
initial begin\
$display(" A = %b ", A);\
$display(" B = %b ", B);\
$display(" Ci = %b ", Ci);\
$display (" C N Z V Y ");\
$monitor (" %b %b %b %b %b ", C, N, Z, V, Y);\
end\
endmodule\
\
//Control Unit Test\
module main;\
reg [31:0] IR;\
reg Cond;\
reg Clk;\
reg MOC;\
reg Clr;\
wire [6:0] State;\
wire reg_win_en, rf_load_en, rf_clear_en, ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, npc_clr, psr_ld, r_w, mov, fr_ld, mc, mf, mm, mop, msa;\
wire [4:0] clear_select;\
wire [1:0] msc, type, ma, mb, mnp, mp;\
wire [5:0] opxx;\
ControlUnit CU(State,reg_win_en, rf_load_en, rf_clear_en, clear_select, ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, npc_clr, psr_ld, r_w, mov, type, fr_ld, ma, mb, mc, mf, mm, mnp, mop, mp, msa, msc, opxx, IR, Cond, Clk, MOC, Clr);\
initial #10000 $finish;\
initial begin\
Clk = 1'b0;\
MOC=1'b0; #3 MOC = 1;\
repeat (100) #5 Clk = ~Clk;#8 MOC = ~MOC;end\
initial fork\
   #3 IR = 32'b10000010001000010100000000000010; // data processing without cc and SIMM13\
   #6 IR = 32'b10000010001000010110000000000010; // data processing SIMM13 without cc \
   #9 IR = 32'b10000010101000010100000000000010;// data processing cc without SIMM13\
   #12 IR = 32'b10000010101000010110000000000010;// data processing cc SIMM13\
   #15 IR = 32'b1000001100000010110000000000010;// SETHI\
   #18 IR = 32'b1100001001010010110000000000010;// load\
   #21 IR = 32'b1100001001010010111000000000010;// load SIMM13\
   #24 IR = 32'b1100001000110001010000000000010;// store\
   #27 IR = 32'b1100001000110001011000000000010;// store SIMM13\
   #30 IR = 32'b0100001000110001011000000000010;// call\
   #33 IR = 32'b1000001111000001010000000000010;// jmpl \
   #36 IR = 32'b1000001111000001011000000000010;// jmpl SIMM13\
   #39 IR = 32'b1000001111001001010000000000010;// rett \
   #42 IR = 32'b1000001111000001011000000000010;// rett SIMM13\
   #45 IR = 32'b0000000010000001010000000000010;// cond true\
   #48 IR = 32'b0001001010000001010000000000010;// cond false a=0\
   #51 IR = 32'b0011001010000001010000000000010;// cond false a=1\
   #54 IR = 32'b0010000010000001010000000000010;// uncond false a=1\
   #57 IR = 32'b1010000101001001010000000000010;// rsr psr\
   #60 IR = 32'b1010000101010001010000000000010;// rsr wim\
   #63 IR = 32'b1010000101011010100000000000010;// rsr tbr\
   #66 IR = 32'b1010000110001101000000000000010;// wsr psr\
   #69 IR = 32'b1010000110001101001000000000010;// wsr psr SIMM13\
   #72 IR = 32'b1010000110010101000000000000010;// wsr wim\
   #75 IR = 32'b1010000110010101001000000000010;// wsr wim SIMM13\
   #78 IR = 32'b1010000110011101000000000000010;// wsr tbr\
   #81 IR = 32'b1010000110011101001000000000010;// wsr tbr SIMM13\
   #84 IR = 32'b1010000111100101000000000000010;// save\
   #87 IR = 32'b1010000111100101001000000000010;// save SIMM13\
   #90 IR = 32'b1010000111101101000000000000010;// restore\
   #93 IR = 32'b1010000111101101001000000000010;// restore SIMM13\
   #96 IR = 32'b1010000111010101000000000000010;// ttr\
   #99 IR = 32'b1010000111010101001000000000010;// ttr SIMM13\
   #3 Cond = 0;\
    Clr =0;\
   #3 Clr = 1;\
join \
initial begin\
    $display(" State reg_win_en rf_load_en rf_clear_en clear_select ir_ld mar_ld mdr_ld wim_ld tbr_ld ttr_ld pc_ld npc_ld npc_clr psr_ld r_w mov type fr_ld ma1 ma0 mb1 mb0 mc mf mm mnp1 mnp0 mop mp1 mp0 msa msc opxx  MOC         Time ");\
    $monitor(" %d %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %d ", State, reg_win_en, rf_load_en, rf_clear_en, clear_select, ir_ld, mar_ld, mdr_ld, wim_ld, tbr_ld, ttr_ld, pc_ld, npc_ld, psr_ld, r_w, mov, type, fr_ld, ma, mb, mc, mf, mm, mnp, mop, mp, msa, msc, opxx, IR, MOC, $time);\
end\
endmodule}