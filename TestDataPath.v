`include "SPARC_Datapath.v"
module TestDataPath;

//Inputs
reg[7:0] Data;
reg [5:0] OpXX, Clear_Select;
reg[1:0]type, MA, MB, MNP, MP, MS, MSc;
reg IR_Ld, MAR_Ld, MDR_Ld, WIM_Ld, TBR_Ld, TTR_Ld, PC_Ld, NPC_Ld, nPC_Clr, PSR_Ld, FR_Ld, RW, MOV, MC, MF, MM, MOP, MSa, 
	Register_Windows_Enable, RF_Load_Enable, RF_Clear_Enable, Clk;


//Outputs
wire [31:0] wIROut, wMAROut;
wire MOC, BCOND, TCOND;

//File variables
integer fi,fo,code,i; 

	DataPath DP(wIROut, wMAROut, MOC, BCOND, TCOND, Register_Windows_Enable, RF_Load_Enable, RF_Clear_Enable, IR_Ld,
	MAR_Ld, MDR_Ld, WIM_Ld, TBR_Ld, TTR_Ld, PC_Ld, NPC_Ld, nPC_Clr, PSR_Ld, RW, MOV, type, FR_Ld, MA, 
	MB, MC, MF, MM, MNP, MOP, MP, MSa, MSc, OpXX, Clk);



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
/*
initial fork
	//Store State 25
	Register_Windows_Enable = 1'b1;
	RF_Load_Enable = 1'b1;
	RF_Clear_Enable = 1'b0;
	OpXX = 5'b00000;
	IR_Ld = 1'b0;
	MAR_Ld = 1'b1;
	MDR_Ld = 1'b0;
	WIM_Ld = 1'b0;
	TBR_Ld = 1'b0;
	TTR_Ld = 1'b0;
	PC_Ld = 1'b0;
	NPC_Ld = 1'b0;
	nPC_Clr = 1'b0;
	PSR_Ld = 1'b0;
	RW = 1'b1;
	MOV = 1'b0;
	type = 1'b0;
	FR_Ld = 1'b0;
	MA = 1'b0;
	MB = 1'b0;
	MC = 1'b0;
	MF = 1'b0;
	MM = 1'b1;
	MNP = 1'b0;
	MOP = 1'b1;
	MP = 1'b0;
	MSa = 1'b0;
	MSc = 1'b0;

join
*/
initial fork
	//Reset State 0
	Register_Windows_Enable = 1'b1;
	RF_Load_Enable = 1'b1;
	RF_Clear_Enable = 1'b1;
	OpXX = 5'b00000;
	IR_Ld = 1'b0;
	MAR_Ld = 1'b0;
	MDR_Ld = 1'b0;
	WIM_Ld = 1'b0;
	TBR_Ld = 1'b0;
	TTR_Ld = 1'b0;
	PC_Ld = 1'b1;
	NPC_Ld = 1'b0;
	nPC_Clr = 1'b1;
	PSR_Ld = 1'b0;
	RW = 1'b1;
	MOV = 1'b0;
	type = 1'b0;
	FR_Ld = 1'b0;
	MA = 1'b0;
	MB = 1'b0;
	MC = 1'b0;
	MF = 1'b0;
	MM = 1'b0;
	MNP = 1'b0;
	MOP = 1'b0;
	MP = 1'b0;
	MSa = 1'b0;
	MSc = 1'b0;
join


//Clock Setup
initial begin
        Clk = 1'b0;
        forever #5 Clk = ~Clk;
end


initial begin
	$display("wMAROut          wIROut				Time");
        $monitor("%d	%h	%d", wMAROut, wIROut, $time);
end

endmodule
