`include "SPARC_MPU.v"

module TestMPU;

//Inputs
reg Clk, Clr, Enable, ReadWrite;
reg[7:0] Data;
reg[8:0] Address; 
reg[1:0] mode;


//Outputs
wire[31:0] wIROut, wMAROut, word;
wire[6:0] State;

//File variables
integer fi,fo,code,i,f; 


parameter sim_time = 2600;


	SPARC_MPU MPU(State, wIROut, wMAROut, Clk, Clr);

initial begin
f=0; 
#sim_time f=1;
end

initial begin
		//Preload RAM with input file
		MPU.CU.CSE.r_w=1'b0;
		MPU.CU.CSE.type=0;
		MPU.DP.MAR.Q=7'b0000000;
		fi=$fopen("input.txt","r");//prueba2.txt
		while(!$feof(fi))begin
			code = $fscanf(fi, "%b", Data);
			MPU.CU.CSE.mov=0;
                        MPU.DP.MDR.Q = Data;
			MPU.CU.CSE.mov=1'b1;
			#1 MPU.DP.MAR.Q=MPU.DP.MAR.Q+1;
		end
		$fclose(fi);


end
initial fork
	Clr = 1'b0;
	#2 Clr = 1'b1;
	#2 Clr = 1'b0;
join


//Clock Setup
initial begin
       	#350 Clk = 1'b0;
        while(f==0)begin
	 #1 Clk = ~Clk;
	end
	wait(f==1);
		fo=$fopen("memcontent.txt","w");
		//
		MPU.CU.CSE.r_w=1'b1;
		MPU.CU.CSE.type=0;
		MPU.DP.MAR.Q=0;
		while(MPU.DP.MAR.Q<=230)
		begin
			MPU.CU.CSE.mov=0;
			MPU.CU.CSE.mov=1'b1;
			#1 wait(MPU.DP.SPARC_RAM.MOC==1)
			begin
				$fdisplay(fo,"Byte en %d = %d",MPU.DP.MAR.Q,MPU.DP.SPARC_RAM.DataOut0[7:0]);
				MPU.DP.MAR.Q=MPU.DP.MAR.Q+1;
			end
		end
end

initial begin
	$display("State    wMAROut	wPCOut		wNPCOut		CNVZ	wALUOut		wMDROut		BCOND     	Time");
        //$display("State    wMAROut	wIROut		wALUOut		wShifterOut	Time");
end

always@(State)
begin
$display("%d    %d	   %h	%h	%b	%h	%h	%b	%d %h",State, wMAROut, MPU.DP.PC.Q, MPU.DP.NPC.Q, MPU.DP.FR.Q, MPU.DP.SPARC_ALU.Y, MPU.DP.MDR.Q, MPU.DP.SPARC_Condition_Tester.BCOND, $time, wIROut);

//$display("%d    %d	   %h	%h	%h	%d",State, wMAROut, MPU.DP.IR.Q, MPU.DP.SPARC_ALU.Y, MPU.DP.SPARC_Shifter.Out, $time);
end


endmodule
