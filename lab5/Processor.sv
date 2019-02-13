//4-bit logic processor top level module
//for use with ECE 385 Fall 2016
//last modified by Zuofu Cheng


//Always use input/output logic types when possible, prevents issues with tools that have strict type enforcement

module Processor (input logic   Clk,     // Internal
                                Reset,   // Push button 0
                                ClearA_LoadB,   // Push button 2
                                Execute, // Push button 3
                  input  logic [7:0]  Din,     // input data

						output logic  X,	
//                  output logic [7:0]  LED,     // DEBUG
//                  output logic [7:0]  Aval,    // DEBUG
 //                               Bval,   
                  output logic [6:0]  AhexL,
                                AhexU,
                                BhexL,
                                BhexU);

	 //local logic variables go here
	 logic Reset_SH, ClearA_LoadB_SH, Execute_SH;
	 logic Ld_A, Ld_B, newA, newB, A_0, B_0, Shift_En, Clear_A;
	 logic [7:0] A, B, Din_S;
	 logic [8:0] Result;
	 logic fn;  // fn = 1 for sub; fn = 0 for add
	 
	 
	 //We can use the "assign" statement to do simple combinational logic
	 assign Aval = A;
	 assign Bval = B;
	// assign LED = {Execute_SH,ClearA_LoadB_SH,Reset_SH}; //Concatenate is a common operation in HDL

	 
	 //Instantiation of modules here
	 register_unit    reg_unit (
                        .Clk(Clk),
                        .Reset(Reset_SH),
                        .Ld_A, //note these are inferred assignments, because of the existence a logic variable of the same name
                        .Ld_B,
								.Clear_A(ClearA),
                        .Shift_En,
                        .Din_A(Result[7:0]),
								.Din_B(Din_S),
                        .A_In(X),
                        .B_In(A_0),
                        .A_out(A_0),
                        .B_out(B_0),  //B_0 is M
                        .A(A),
                        .B(B) );
	 ADD_SUB9		compute(
								.A(A),
								.S(Din_S),   // S is value of switches
								.fn(fn),
								.Result(Result),
								.X(X)	);
 /*   compute          compute_unit (
								.F(F_S),
                        .A_In(opA),
                        .B_In(opB),
                        .A_Out(bitA),
                        .B_Out(bitB),
                        .F_A_B );
    router           router (
								.R(R_S),
                        .A_In(bitA),
                        .B_In(bitB),
                        .A_Out(newA),
                        .B_Out(newB),
                        .F_A_B );
*/
	 control          control_unit (
                        .Clk(Clk),
                        .Reset(Reset_SH),
                        .ClearA_LoadB(ClearA_LoadB_SH),
                        .Execute(Execute_SH),
								.M0(B_0),
                        .Shift_En,
                        .Ld_A,
                        .Ld_B,
								.fn(fn),
							   .ClearA(Clear_A) );
	 HexDriver        HexAL (
                        .In0(A[3:0]),
                        .Out0(AhexL) );
	 HexDriver        HexBL (
                        .In0(B[3:0]),
                        .Out0(BhexL) );
								
	 //When you extend to 8-bits, you will need more HEX drivers to view upper nibble of registers, for now set to 0
	 HexDriver        HexAU (
                        .In0(A[7:4]),
                        .Out0(AhexU) );	
	 HexDriver        HexBU (
                       .In0(B[7:4]),
                        .Out0(BhexU) );
								
	  //Input synchronizers required for asynchronous inputs (in this case, from the switches)
	  //These are array module instantiations
	  //Note: S stands for SYNCHRONIZED, H stands for active HIGH
	  //Note: We can invert the levels inside the port assignments
	  sync button_sync[2:0] (Clk, {~Reset, ~ClearA_LoadB, ~Execute}, {Reset_SH, ClearA_LoadB_SH, Execute_SH});
	  sync Din_sync[7:0] (Clk, Din, Din_S);
	  
endmodule
