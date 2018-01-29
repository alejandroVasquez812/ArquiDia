module alu (output reg [31:0] Y, output reg N, Z, C, V, input [5:0]op, input signed  [31:0]A, input signed [31:0]B, input Ci);
always@(op,A,B)
begin
case(op)
6'b000000: Y=A+B; // ADD
6'b000001:begin{C,Y}=A&B; N=Y[31];
if(Y==0) Z=1;
else Z=0;
V=0;
end // AND bitwise
6'b010001:begin{C,Y}=A&B; // AND bitwise modify cc
N=Y[31];
if(Y==0) Z=1;
else Z=0;
V=0;
end
6'b000101: Y=A&(~B); //A AND NOT B
6'b010101: begin {C,Y}=A&(~B); //A AND NOT B modify cc
N=Y[31];
if(Y==0) Z=1;
else Z=0;
V=0;
end
6'b000010: Y=A|B; // OR bitwise
6'b010010:begin {C,Y}=A|B; // OR bitwise modify cc
N=Y[31];
if(Y==0) Z=1;
else Z=0;
V=0;
end
6'b000110: Y=A|(~B); // A OR bitwise NOT B
6'b010110: begin {C,Y}=A|(~B); // A OR bitwise NOT B modify cc
N=Y[31];
if(Y==0) Z=1;
else Z=0;
V=0;
end
6'b000011: Y=A^B; // XOR bitwise
6'b010011:begin {C,Y}=A^B; // XOR bitwise modify cc
N=Y[31];
if(Y==0) Z=1;
else Z=0;
V=0;
end
6'b000111: Y=A^(~B); // A XOR bitwise NOT B
6'b010111:begin {C,Y}=A^(~B); // A XOR bitwise NOT B modify cc
N=Y[31];
if(Y==0) Z=1;
else Z=0;
V=0;
end
6'b010000: begin {C,Y}=A+B;//ADD modify cc
N=Y[31];
if(Y==0)Z=1;
else Z=0;
if(A[31]==B[31] && Y[31]!=A[31]) V=1;
else V=0;
end
6'b001000: Y=A+B+Ci;//ADD plus carry
6'b011000: begin {C,Y}=A+B+Ci;//ADD plus carry modify cc
N=Y[31];
if(Y==0) Z=1;
else Z=0;
if(A[31]==B[31]&& Y[31]!=A[31])V=1;
else V=0;
end
6'b000100: Y=A-B;//SUB

6'b010100: begin {C,Y}=A-B;//SUB modify cc
//6'b010100: begin Y = A-B;
N=Y[31];
if(Y == 0) Z=1;
else Z=0;
//Z = ~(|Y);
if(A[31]!=B[31]&&Y[31]!=A[31]) V=1;
else V=0;
C = 0;
end
6'b001100: Y=A-B-Ci; //SUB minus carry
6'b011100: begin {C,Y}=A-B-Ci;//SUB minus carry modify cc
N=Y[31];
if(Y==0) Z=1;
else Z=0;
if(A[31]!=B[31]&&Y[31]!=A[31]) V=1;
else V=0;
end
6'b100101: Y=A<<B[4:0];//logical shift left
6'b100110: Y=A>>B[4:0]; //logical shift right
6'b100111: Y=A>>>B[4:0]; // arithmetic shift right

//NEW
6'b100000: Y=A;
6'b100001: Y=B;
6'b100010: Y={A[31:5],A[4:0]- 1'b1};
6'b100011: Y={A[31:5],A[4:0]+1'b1};
6'b100100: Y={A[31:8],A[6],A[6],1'b1,A[4:0]+1'b1};
6'b011111: Y={A[31:8],1'b1,A[7],1'b0,A[4:0]-1'b1};

6'b111111:
begin
	Y = B - 4;
end

endcase
//$display("Y = %d A= %d B=%d",Y,A,B);
end
endmodule
