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
integer fi,fo,code,i; 


parameter sim_time = 10000;


	SPARC_MPU MPU(State, wIROut, wMAROut, Clk, Clr);

initial #sim_time $finish;

initial begin
		//Preload RAM with input file
		MPU.CU.CSE.r_w=1'b0;
		MPU.CU.CSE.type=0;
		MPU.DP.MAR.Q=7'b0000000;
		fi=$fopen("input.txt","r");
		while(!$feof(fi))begin
			code = $fscanf(fi, "%b", Data);
			MPU.CU.CSE.mov=0;
                        MPU.DP.MDR.Q = Data;
			#1 MPU.CU.CSE.mov=1'b1;
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
         Clk = 1'b0;
        forever #115 Clk = ~Clk;
end

initial begin
	//$display("State       wMAROut         wIROut		         Time");
      //  $monitor("%d    %d	   %h	%d",State, wMAROut, wIROut, $time);
end

endmodule
