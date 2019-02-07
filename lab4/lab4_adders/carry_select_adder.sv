module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           Co
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  logic c4_final, c8_final, c12_final, c16_final; //Final carry-outs when the mux selected the correct carry-out.
	  
	  logic c8_0, c12_0, c16_0; // Carry-out for 0 carry-in
	  logic c8_1, c12_1, c16_1; // Carry-out for 1 carry-in

	  
	  logic [3:0] s4_0, s8_0, s12_0, s16_0; // Sum for 0 carry-in
	  logic [3:0] s4_1, s8_1, s12_1, s16_1; // Sum for 1 carry-in
	  
	  ra4 RA4(.A(A[3:0]), .B(B[3:0]), .Sum(Sum[3:0]), .Co(c4_final));
	  
	  ra4 RA8_0(.A(A[7:4]), .B(B[7:4]), .Sum(s8_0), .Co(c8_0));
	  ra4 RA12_0(.A(A[11:8]), .B(B[11:8]), .Sum(s12_0), .Co(c12_0));
	  ra4 RA16_0(.A(A[15:12]), .B(B[15:12]), .Sum(s16_0), .Co(c16_0));

	  ra4 RA8_1(.A(A[7:4]), .B(B[7:4]), .Sum(s8_1), .Co(c8_1));
	  ra4 RA12_1(.A(A[11:8]), .B(B[11:8]), .Sum(s12_1), .Co(c12_1));
	  ra4 RA16_1(.A(A[15:12]), .B(B[15:12]), .Sum(s16_1), .Co(c16_1));
	  
	  
	  //Muxes for Sums 
	  mux21_4bit SUM_MUX8(.In0(s8_0), .In1(s8_1), .Sel(c4_final), .Out(Sum[7:4]));
	  mux21_4bit SUM_MUX12(.In0(s12_0), .In1(s12_1), .Sel(c8_final), .Out(Sum[11:8]));
	  mux21_4bit SUM_MUX16(.In0(s16_0), .In1(s16_1), .Sel(c12_final), .Out(Sum[15:12]));
	  
	  //Muxes for carry outs
	  mux21_1bit CO_MUX8(.In0(c8_0), .In1(c8_1), .Sel(c4_final), .Out(c8_final));
	  mux21_1bit CO_MUX12(.In0(c12_0), .In1(c12_1), .Sel(c8_final), .Out(c12_final));
	  mux21_1bit CO_MUX16(.In0(c16_0), .In1(c16_1), .Sel(c12_final), .Out(c16_final));
	  
	  assign Co = c16_final;	 
endmodule
