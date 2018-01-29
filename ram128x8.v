module ram128x8(output reg[7:0] DataOut,output reg MOC, input Enable, ReadWrite, input [8:0] Address, input [7:0] DataIn);
reg [7:0] Mem [0:127];
always @ (posedge Enable) begin
		MOC=0;
		if(Enable)begin
		
			if(ReadWrite)begin
				DataOut=Mem[Address>>>2];
				MOC=1;
				//$display("Data leida del Address %d es %d   %d",Address,DataOut,$time);
				end
			else begin
				Mem[Address>>>2]=DataIn;
				MOC=1;
				//$display("Data escrita en el Address %d es %b   %d",Address,DataIn,$time);
				end
		 end
	  #1 MOC=0;
		end
endmodule
