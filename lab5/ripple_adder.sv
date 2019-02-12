module ra4
(
    input   logic[3:0]     A,
    input   logic[3:0]     B,
	 input   logic          Cin,
    output  logic[3:0]     Sum,
    output  logic          Co
);

logic c1, c2, c3;

full_adder FA0(.x(A[0]), .y(B[0]), .z(Cin), .s(Sum[0]), .c(c1));
full_adder FA1(.x(A[1]), .y(B[1]), .z(c1), .s(Sum[1]), .c(c2));
full_adder FA2(.x(A[2]), .y(B[2]), .z(c2), .s(Sum[2]), .c(c3));
full_adder FA3(.x(A[3]), .y(B[3]), .z(c3), .s(Sum[3]), .c(Co));
endmodule

//this is the module to add/sub S to A
module ADD_SUB9
(
	input		logic[7:0]		A,
	input		logic[7:0]		S,
	input		logic			fn,  // fn=0 for add and fn=1 for subtract
	output	logic[8:0]		Result, // 9 bit result
	output 	logic			X
);

	logic c4, c8;
	logic[7:0]			SS; //internal S or NOT(S)
	logic A8, SS8;
	
	assign SS = (S ^ {8{fn}});  //when fn = 1, complement S
	assign A8 = A[7];   //sign extension bit
	assign SS8 = SS[7];
	ra4 RA0(.A(A[3:0]), .B(SS[3:0]), .Sum(Result[3:0]), .Cin(0), .Co(c4));
	ra4 RA4(.A(A[7:4]), .B(SS[7:4]), .Sum(Result[7:4]), .Cin(c4), .Co(c8));
	full_adder FA(.x(A8), .y(SS8), .z(c8), .s(Result[8]), .c());
	assign X = Result[8];
endmodule
