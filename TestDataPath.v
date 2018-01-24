`include "SPARC_Datapath.v"
module TestDataPath;

//Inputs
reg[7:0] Data;
reg [5:0] OpXX;
reg[1:0]type, MA, MB, MNP, MP, MS, MSc;
reg IR_Ld, MAR_Ld, MDR_Ld, WIM_Ld, TBR_Ld, TTR_Ld, PC_Ld, NPC_Ld, nPC_Clr, PSR_Ld, FR_Ld, RW, MOV, MC, MF, MM, MR, MOP, MSa, 
	Register_Windows_Enable, RF_Load_Enable, RF_Clear_Enable, Clk;


//Outputs
wire [31:0] wIROut, wMAROut;
wire MOC, BCOND, TCOND;

//File variables
integer fi,fo,code,i; 

parameter sim_time = 10000;

	DataPath DP(wIROut, wMAROut, MOC, BCOND, TCOND, Register_Windows_Enable, RF_Load_Enable, RF_Clear_Enable, IR_Ld,
	MAR_Ld, MDR_Ld, WIM_Ld, TBR_Ld, TTR_Ld, PC_Ld, NPC_Ld, nPC_Clr, PSR_Ld, RW, MOV, type, FR_Ld, MA, 
	MB, MC, MF, MM, MR, MNP, MOP, MP, MSa, MSc, OpXX, Clk);

initial #sim_time $finish;

initial begin
		//Preload RAM with input file
		RW=1'b0;
		type=0;
		DP.MAR.Q=7'b0000000;
		fi=$fopen("input.txt","r");
		while(!$feof(fi))begin
			code = $fscanf(fi, "%b", Data);
			MOV=0;
                        DP.MDR.Q = Data;
			#1 MOV=1'b1;
			#1 DP.MAR.Q=DP.MAR.Q+1;
		end
		$fclose(fi);


end

initial fork
	#10;
	//Reset State 0
	Register_Windows_Enable = 1'b0;
	RF_Load_Enable = 1'b0;
	RF_Clear_Enable = 1'b1;
	OpXX = 5'b00000;
	IR_Ld = 1'b0;
	MAR_Ld = 1'b0;
	MDR_Ld = 1'b0;
	WIM_Ld = 1'b0;
	TBR_Ld = 1'b0;
	TTR_Ld = 1'b0;
	PC_Ld = 1'b1;
	NPC_Ld = 1'b1;
	nPC_Clr = 1'b0;
	PSR_Ld = 1'b0;
	RW = 1'b0;
	MOV = 1'b0;
	type = 2'b00;
	FR_Ld = 1'b0;
	MA = 2'b00;
	MB = 2'b00;
	MC = 1'b0;
	MF = 1'b0;
	MM = 1'b0;
	MR = 1'b1;
        MP = 2'b00;
	MNP = 2'b11;
	MOP = 1'b0;
	MP = 2'b00;
	MS = 2'b00;
	MSa = 1'b0;
	MSc = 2'b00;
/*
	#10;
	//Fetch1
	Register_Windows_Enable = 1'b0;
	RF_Load_Enable = 1'b0;
	RF_Clear_Enable = 1'b0;
	OpXX = 5'b10001;
	IR_Ld = 1'b0;
	MAR_Ld = 1'b1;
	MDR_Ld = 1'b0;
	WIM_Ld = 1'b0;
	TBR_Ld = 1'b0;
	TTR_Ld = 1'b0;
	PC_Ld = 1'b0;
	NPC_Ld = 1'b1;
	nPC_Clr = 1'b0;
	PSR_Ld = 1'b0;
	RW = 1'b0;
	MOV = 1'b0;
	type = 2'b00;
	FR_Ld = 1'b0;
	MA = 2'b00;
	MB = 2'b10;
	MC = 1'b0;
	MF = 1'b0;
	MM = 1'b0;
        MP = 2'b00;
	MNP = 2'b11;
	MOP = 1'b1;
	MP = 1'b0;
	MS = 2'b00;
	MSa = 1'b0;
	MSc = 2'b00;

	#10;
//Fetch 2
	Register_Windows_Enable = 1'b0;
	RF_Load_Enable = 1'b0;
	RF_Clear_Enable = 1'b0;
	OpXX = 5'b00000;
	IR_Ld = 1'b1;
	MAR_Ld = 1'b0;
	MDR_Ld = 1'b0;
	WIM_Ld = 1'b0;
	TBR_Ld = 1'b0;
	TTR_Ld = 1'b0;
	PC_Ld = 1'b1;
	NPC_Ld = 1'b0;
	nPC_Clr = 1'b0;
	PSR_Ld = 1'b0;
	RW = 1'b1;
	MOV = 1'b1;
	type = 2'b10;
	FR_Ld = 1'b0;
	MA = 2'b00;
	MB = 2'b00;
	MC = 1'b0;
	MF = 1'b0;
	MM = 1'b0;
        MP = 2'b00;
	MNP = 2'b00;
	MOP = 1'b0;
	MP = 2'b11;
	MS = 2'b00;
	MSa = 1'b0;
	MSc = 2'b00;

	#10;
//Fetch 3
	Register_Windows_Enable = 1'b0;
	RF_Load_Enable = 1'b0;
	RF_Clear_Enable = 1'b0;
	OpXX = 5'b00000;
	IR_Ld = 1'b1;
	MAR_Ld = 1'b0;
	MDR_Ld = 1'b0;
	WIM_Ld = 1'b0;
	TBR_Ld = 1'b0;
	TTR_Ld = 1'b0;
	PC_Ld = 1'b0;
	NPC_Ld = 1'b0;
	nPC_Clr = 1'b0;
	PSR_Ld = 1'b0;
	RW = 1'b1;
	MOV = 1'b1;
	type = 2'b10;
	FR_Ld = 1'b0;
	MA = 2'b00;
	MB = 2'b00;
	MC = 1'b0;
	MF = 1'b0;
	MM = 1'b0;
        MP = 2'b00;
	MNP = 2'b00;
	MOP = 1'b0;
	MP = 1'b0;
	MS = 2'b00;
	MSa = 1'b0;
	MSc = 2'b00;

	#10;
//Decode
	Register_Windows_Enable = 1'b0;
	RF_Load_Enable = 1'b0;
	RF_Clear_Enable = 1'b0;
	OpXX = 5'b00000;
	IR_Ld = 1'b0;
	MAR_Ld = 1'b0;
	MDR_Ld = 1'b0;
	WIM_Ld = 1'b0;
	TBR_Ld = 1'b0;
	TTR_Ld = 1'b0;
	PC_Ld = 1'b0;
	NPC_Ld = 1'b0;
	nPC_Clr = 1'b0;
	PSR_Ld = 1'b0;
	RW = 1'b0;
	MOV = 1'b0;
	type = 2'b00;
	FR_Ld = 1'b0;
	MA = 2'b00;
	MB = 2'b00;
	MC = 1'b0;
	MF = 1'b0;
	MM = 1'b0;
        MP = 2'b00;
	MNP = 2'b00;
	MOP = 1'b0;
	MP = 1'b0;
	MS = 2'b00;
	MSa = 1'b0;
	MSc = 2'b00;

	#10;
//State 11
	Register_Windows_Enable = 1'b1;
	RF_Load_Enable = 1'b1;
	RF_Clear_Enable = 1'b0;
	OpXX = 5'b00000;
	IR_Ld = 1'b0;
	MAR_Ld = 1'b0;
	MDR_Ld = 1'b0;
	WIM_Ld = 1'b0;
	TBR_Ld = 1'b0;
	TTR_Ld = 1'b0;
	PC_Ld = 1'b1;
	NPC_Ld = 1'b0;
	nPC_Clr = 1'b0;
	PSR_Ld = 1'b0;
	RW = 1'b1;
	MOV = 1'b1;
	type = 2'b10;
	FR_Ld = 1'b0;
	MA = 2'b00;
	MB = 2'b01;
	MC = 1'b0;
	MF = 1'b0;
	MM = 1'b0;
        MP = 2'b00;
	MNP = 2'b00;
	MOP = 1'b0;
	MP = 1'b0;
	MS = 2'b00;
	MSa = 1'b0;
	MSc = 2'b00;
*/
join


//Clock Setup
initial begin
        Clk = 1'b0;
        forever #5 Clk = ~Clk;
end


initial begin
	$display("wMAROut          wIROut		wPCOut		wNPCOut			Time");
        $monitor("%d	%h	%h	%h	%d", wMAROut, wIROut, DP.PC.Q, DP.NPC.Q, $time);
end

endmodule
