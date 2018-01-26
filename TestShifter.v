`include "Shifter_And_SignExtender.v"
module TestShifter;

parameter sim_time = 10000;

	Shifter_And_Sign_Extender Shifter();

initial #sim_time $finish;


initial begin
	$display("wMAROut          wIROut				Time");
        $monitor("%d	%h	%d", wMAROut, wIROut, $time);
end


endmodule
