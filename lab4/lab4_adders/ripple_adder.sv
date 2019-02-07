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


module ripple_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           Co
);

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	 logic c4, c8, c12;
	 ra4 RA0(.A(A[3:0]), .B(B[3:0]), .Sum(Sum[3:0]), .Cin(0), .Co(c4));
	 ra4 RA4(.A(A[7:4]), .B(B[7:4]), .Sum(Sum[7:4]), .Cin(c4), .Co(c8));
	 ra4 RA8(.A(A[11:8]), .B(B[11:8]), .Sum(Sum[11:8]), .Cin(c8), .Co(c12));
	 ra4 RA12(.A(A[15:12]), .B(B[15:12]), .Sum(Sum[15:12]), .Cin(c12), .Co(Co));
	 
endmodule
