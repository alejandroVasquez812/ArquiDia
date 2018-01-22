`include "ALU.v"
`include "RAM.v"
`include "Register_Windows.v"
`include "Condition_Tester.v"
`include "Flag_Register.v"
`include "Shifter_And_SignExtender.v"

module DataPath(output [31:0] wIROut, wMAROut, output MOC, BCOND, TCOND, input Register_Windows_Enable, RF_Load_Enable, RF_Clear_Enable, input IR_Ld, MAR_Ld, MDR_Ld, WIM_Ld, TBR_Ld, TTR_Ld, PC_Ld, NPC_Ld, nPC_Clr, PSR_Ld, RW, MOV,input[1:0]type, input FR_Ld, input [1:0] MA, MB,input MC, MF, MM,input [1:0] MNP,input MOP, input [1:0] MP, input MSa,input [1:0] MSc, input [5:0] OpXX, input Clk);

wire[31:0] wALUOut, wDataOut, wIROut, wMAROut, wMDROut, wPCOut, wNPCOut, wShifterOut, wAddShifterOut, wAddNPCOut, wAddSumNPCOut,wMuxMOut, wMuxPOut, wMuxNPOut, wWIMOut, wPortA, wPortB, wMuxAOut, wMuxBOut, wMuxCOut;

	wire[5:0] wMuxOPOut;
        wire [4:0] wMuxSaOut, wMuxScOut ;
        wire[28:0] wTBROut;
	wire[27:0] wPSROut;
	wire[2:0] wTTROut;
	wire[3:0] wFROut, wMuxFOut;

	wire TCond;
	supply0 Gnd;


	alu SPARC_ALU(wALUOut, wN, wZ, wC, wV, wMuxOPOut, wMuxAOut, wMuxBOut, wFROut[3]);
	RamAccess SPARC_RAM(wDataOut, MOC, MOV, RW, wMAROut[8:0], wMDROut, type);

//always@(wALUOut)
//begin
//$display("wALUOut= %b",wALUOut);
//end

	Register_Windows SPARC_Register_Windows(wPortA, wPortB, wALUOut, wMuxSaOut, wIROut[4:0], wMuxScOut, wPSROut[1:0], RF_Load_Enable, RF_Clear_Enable, Register_Windows_Enable, Clk);


	Condition_Tester SPARC_Condition_Tester(BCOND, TCOND, wIROut[31:25], wWIMOut[3:0], wPSROut[11:0], wC, wN, wV, wZ);
	Shifter_And_SignExtender SPARC_Shifter(wShifterOut, wIROut);
//always@(wShifterOut, wIROut)
//begin
//$display("wIROut= %b  wShifterOut= %b",wIROut, wShifterOut);
//end

//*********************************
//	DataPath Registers
//*********************************
	Register_32Bits MAR(wMAROut, wALUOut, Clk, Gnd, MAR_Ld);

//always@(wMAROut, wALUOut, Clk, Gnd, MAR_Ld)
//begin
//$display("wMAROut= %b wALUOut= %b Clk= %b Gnd= %b MAR_Ld= %b",wMAROut, wALUOut, Clk, Gnd, MAR_Ld);
//end


	Register_32Bits MDR(wMDROut, wMuxMOut, Clk, Gnd, MDR_Ld);


	Register_32Bits IR(wIROut, wDataOut, Clk, Gnd, IR_Ld);
	Register_32Bits PC(wPCOut, wMuxPOut, Clk, Gnd, PC_Ld);


	Register_32Bits NPC(wNPCOut, wMuxNPOut, Clk, nPC_Clr, NPC_Ld);
	and(wWIM_Ld, WIM_Ld, wPSROut[7]);
	Register_32Bits WIM(wWIMOut, wALUOut, Clk, Gnd, WIM_Ld);

//always@(wNPCOut, wMuxNPOut, Clk, nPC_Clr, NPC_Ld)
//begin
//$display("wNPCOut= %b wMuxNPOut= %b Clk= %b nPC_Clr= %b NPC_Ld= %b",wNPCOut, wMuxNPOut, Clk, nPC_Clr, NPC_Ld);
//end

	and(wTBR_Ld, TBR_Ld, wPSROut[7]);
	Register_29Bits TBR(wTBROut, {wALUOut[31:7], wALUOut[3:0]}, Clk, Gnd, TBR_Ld);
	Register_3Bits TTR(wTTROut, wALUOut[6:4], CLk, Gnd, TTR_Ld);


	and(wPSR_TCond, PSR_Ld, wTCond);
	and(wPSR_Sup, PSR_Ld, wPSROut[7]);
	or(wPSR_Ld, wPSR_TCond, wPSR_Sup);
	Register_28Bits PSR(wPSROut, {wALUOut[31:24],wALUOut[19:0]}, Clk, Gnd, wPSR_Ld);

	FlagRegister FR(wFROut, {wC, wN, wV, wZ}, Clk, FR_Ld);


//*********************************
//	Adders
//*********************************
	Bit_Adder AddShifter(wAddShifterOut, wPCOut, wShifterOut);
	Bit_Adder AddNPC(wAddNPCOut, 32'h00000004, wNPCOut);
	Bit_Adder AddSumNPC(wAddSumNPCOut, 32'h00000004, wAddNPCOut);
//always@(wAddSumNPCOut, wAddNPCOut)
//begin
//$display("wAddSumNPCOut= %d, wAddNPCOut= %d",wAddSumNPCOut, wAddNPCOut);
//end

//*********************************
//	DataPath Multiplexers
//*********************************
	Mux32_4x1 MuxA(wMuxAOut, wPortA, {wPSROut[31:24], wFROut, wPSROut[19:0]}, wWIMOut, {wTBROut[28:4], wTTROut, wTBROut[3:0]}, MA); 
	Mux32_4x1 MuxB(wMuxBOut, wPortB, wShifterOut, wMuxCOut, wMDROut, MB); 
//always@(wMuxBOut, wPortB, wShifterOut, wMuxCOut, wMDROut, MB)
//begin
//$display("wMuxBOut= %d, wPortB= %d, wShifterOut= %d, wMuxCOut= %d, wMDROut=%d, MB= %d",wMuxBOut, wPortB, wShifterOut, wMuxCOut, wMDROut, MB);
//end

	Mux32_2x1 MuxC(wMuxCOut, wPCOut, wNPCOut, MC);
	Mux32_2x1 MuxM(wMuxMOut, wDataOut,  wALUOut, MM);


	Mux32_4x1 MuxNP(wMuxNPOut, wALUOut, wAddSumNPCOut, wAddShifterOut, wAddNPCOut, MNP);

//always@(wMuxNPOut, wALUOut, wAddSumNPCOut, wAddShifterOut, wAddNPCOut, MNP)
//begin
//$display("wMuxNPOut= %d wALUOut= %b wAddSumNPCOut= %b wAddShifterOut= %b wAddNPCOut= %b MNP= %b",wMuxNPOut, wALUOut, wAddSumNPCOut, wAddShifterOut, wAddNPCOut, MNP);
//end
	Mux32_4x1 MuxP(wMuxPOut, 32'h00000000, {wTBROut[28:4], wTTROut, wTBROut[3:0]}, wAddNPCOut, wNPCOut,MP);
	Mux5_2x1 MuxSa(wMuxSaOut, wIROut[18:14], wIROut[29:25], MSa); 


	Mux5_4x1 MuxSc(wMuxScOut, wIROut[29:25], 5'h0F, 5'h11, 5'h12,MSc);
	Mux6_2x1 MuxOP(wMuxOPOut, wIROut[24:19], OpXX, MOP);
	Mux4_2x1 MuxF(wMuxFOut, {wC, wN, wV, wZ}, wALUOut[23:20], MF);

endmodule





module Mux6_2x1(output reg [5:0] Out, input [5:0] A, B, input S);
always@(S,A,B)
begin
        if(S)
                Out = B;
        else
                Out = A;
end
endmodule


module Mux5_4x1(output reg [4:0] Out, input [4:0] A, B, C, D, input [1:0] S);
always@(S,A,B,C,D)
begin
        case(S)
        2'b00:
                Out = A;
        2'b01:
                Out = B;
        2'b10:
                Out = C;
        2'b11:
                Out = D;
        endcase
end
endmodule


module Mux5_2x1(output reg [4:0] Out, input [4:0] A, B, input S);
always@(S,A,B)
begin
        if(S)
                Out = B;
        else
                Out = A;
end
endmodule


module Mux4_2x1(output reg [3:0] Out, input [3:0] A, B, input S);
always@(S,A,B)
begin
        if(S)
                Out = B;
        else
                Out = A;
end
endmodule


//*****************************
//	Decoder Modules
//*****************************

//*****************************
//	Register Modules
//*****************************


module Register_29Bits(output reg [28:0] Q, input [28:0] D, input Clk, Clr, Le);
always@(posedge Clk, Clr) //Reminder: Possible Change to Clr in negedge
begin
if(Clr)
        Q <= 29'h00000000;
else if(Le)
        Q <= D;
else
        Q <= Q;
end
endmodule


module Register_28Bits(output reg [27:0] Q, input [27:0] D, input Clk, Clr, Le);
always@(posedge Clk, Clr) //Reminder: Possible Change to Clr in negedge
begin
if(Clr)
        Q <= 28'h0000000;
else if(Le)
        Q <= D;
else
        Q <= Q;
end
endmodule


module Register_3Bits(output reg [2:0] Q, input [2:0] D, input Clk, Clr, Le);
always@(posedge Clk, Clr) //Reminder: Possible Change to Clr in negedge
begin
if(Clr)
        Q <= 4'h0;
else if(Le)
        Q <= D;
else
        Q <= Q;
end
endmodule



//*******************************
//	Adders
//*******************************
module Bit_Adder(output [31:0] S, input [31:0] A, input [31:0] B);
	assign S = A + B;
endmodule
