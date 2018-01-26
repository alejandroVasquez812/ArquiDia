

module FlagRegister(output reg [3:0] Q, input [3:0] D, input Clk, Le);
always@(posedge Clk,posedge Le)
begin
if(Clk)begin
if(Le)
	Q <= D;
end
else
	Q <= Q;
end
endmodule
