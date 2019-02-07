module cla4
(
	input logic[3:0]  A,
	input logic[3:0]  B,
	input logic       Cin,
	output logic[3:0] Sum,
	output logic      Co,
	output logic      Pg,
	output logic      Gg
);

logic p0, p1, p2, p3;
logic g0, g1, g2, g3;
logic c0, c1, c2, c3;

full_adder FA0(.x(A[0]), .y(B[0]), .z(C0), .s(Sum[0]));
full_adder FA1(.x(A[1]), .y(B[1]), .z(C1), .s(Sum[1]));
full_adder FA2(.x(A[2]), .y(B[2]), .z(C2), .s(Sum[2]));
full_adder FA3(.x(A[3]), .y(B[3]), .z(C3), .s(Sum[3]));

assign Co = (c0 & p0 & p1 & p2 & p3) | (g0 & p1 & p2 & p3) | (g1 & p2 & p3) | (g2 & p3) | g3;
assign Pg = p0 & p1 & p2 & p3;
assign Gg = g3 | (g2 & p3) | (g1 & p3 & p2) | (g0 & p3 & p2 & p1);

always_comb
	begin
		g0 = A[0] & B[0];
		g1 = A[1] & B[1];
		g2 = A[2] & B[2];
		g3 = A[3] & B[3];
		
		p0 = A[0] ^ B[0];
		p1 = A[1] ^ B[1];
		p2 = A[2] ^ B[2];
		p3 = A[3] ^ B[3];
	
		c0 = Cin;
		c1 = (c0 & p0) | g0;
		c2 = (c0 & p0 & p1) | (g0 & p1) | g1;
		c3 = (c0 & p0 & p1 & p2) | (g0 & p1 & p2) | (g1 & p2) | g2;
	end
endmodule



module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           Co
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
logic p0, p4, p8, p12;
logic g0, g4, g8, g12;
logic c0, c4, c8, c12;

cla4 CLA0(.A(A[3:0]), .B(B[3:0]), .z(C0), .s(Sum[3:0]), .Gg(g0), .Pg(p0));
cla4 CLA1(.A(A[7:4]), .B(B[7:4]), .z(C4), .s(Sum[7:4]), .Gg(g4), .Pg(p4));
cla4 CLA2(.A(A[11:8]), .B(B[11:8]), .z(C8), .s(Sum[11:8]), .Gg(g8), .Pg(p8));
cla4 CLA3(.A(A[15:12]), .B(B[15:12]), .z(C12), .s(Sum[15:12]), .Gg(g12), .Pg(p12));

assign Co = g12 | (g8 & p12) | (g4 & p12 & p8) | (g0 & p12 & g8 & g4);

always_comb
	begin

	c0 = 0;

	//Neglecting last terms since c0 = 0
	c4 = g0;
	c8 = g4 | (g0 & p4);
	c12 = g8 | (g4 & p8) | (g0 & p8 & p4);
	end	  
     
endmodule
