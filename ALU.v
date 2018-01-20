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
N=Y[31];
if(Y==0) Z=1;
else Z=0;
if(A[31]!=B[31]&&Y[31]!=A[31]) V=1;
else V=0;
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
endcase
end
endmodule
module test_alu;
reg [5:0]op;
reg [31:0]A;
reg [31:0]B;
reg Ci;
wire [31:0]Y;
wire N,Z,C,V;
alu alu1(Y, N, Z, C, V, op, A, B, Ci);
initial #500 $finish;
initial fork
A = 32'b00000000000000000000000000001000;
B = 32'b00000000000000000000000000000111;
Ci=1;
//Operations that not modify the condition codes
op = 6'b000000;       //add 
#10 op = 6'b001000;   //addx
#20 op = 6'b000100;   //sub
#30 op = 6'b001100;   // subx
#40 op = 6'b000001;   //and
#50 op = 6'b000101;   //andn
#60 op = 6'b000010;   //or
#70 op = 6'b000110;   //orn
#80 op = 6'b000011;   //xor
#90 op = 6'b000111;   //xorn
#100 op = 6'b100101;  //sll
#110 op = 6'b100110;  // srl
#120 op = 6'b100111;  // sra
//Operations that modify the condition codes
#130 op = 6'b010000; //addcc
#140 op = 6'b011000; //addxcc
#150 op = 6'b010100; //subcc
#160 op = 6'b011100; //subxcc
#170 op = 6'b010001; //andcc
#180 op = 6'b010101; //andncc
#190 op = 6'b010010; //orcc
#200 op = 6'b010110; //orncc
#210 op = 6'b010011; //xorcc
#220 op = 6'b010111; //xorncc
#330 op = 6'b100000; //Y=A
#340 op = 6'b100001; //Y=B
#350 op = 6'b100010; // Y={A[31:5],A[4:0]-1}
#360 op = 6'b100011; //Y={A[31:5],A[4:0]+1}
#370 op = 6'b100100; //Y={A[31:8],A[6],A[6],1'b1,A[4:0]+1'b1};
#380 op = 6'b011111; //Y={A[31:8],1'b1,A[7],1'b0,A[4:0]-1'b1};
join
initial begin
$display(" A = %b ", A);
$display(" B = %b ", B);
$display(" Ci = %b ", Ci);
$display (" C N Z V Y ");
$monitor (" %b %b %b %b %b ", C, N, Z, V, Y);
end
endmodule