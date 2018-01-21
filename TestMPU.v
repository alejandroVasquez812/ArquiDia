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


parameter sim_time = 5000;


	SPARC_MPU MPU(State, wIROut, wMAROut, Clk, Clr);

initial #sim_time $finish;

initial begin
		//Preload RAM with input file
		ReadWrite=1'b0;
		mode=0;
		Address=7'b0000000;
		fi=$fopen("input.txt","r");
		while(!$feof(fi))begin
			code = $fscanf(fi, "%b", Data);
			Enable=0;
                        MPU.DP.SPARC_RAM.ram.Mem[Address] = Data;
			#1 Enable=1'b1;
			#1 wait(MPU.DP.SPARC_RAM.MOC1==1);
			#1 Address=Address+1;
		end
		$fclose(fi);


end
initial fork
	Clr = 1'b1;
	#2 Clr = 1'b0;
	#2 Clr = 1'b1;
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
