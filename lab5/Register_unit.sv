module register_unit (input  logic Clk, Reset, A_In, B_In, Ld_A, Ld_B, 
									 Clear_A, Shift_En,
                      input  logic [7:0]  Din_A,
							 input  logic [7:0]	Din_B, 
                      output logic A_out, B_out, 
                      output logic [7:0]  A,
                      output logic [7:0]  B);
	logic DinA;
	
always_ff @ (posedge Clk)  
   begin
	if (Clear_A)
		DinA <= 8'h0;
	else 
		DinA <= Din_A;
	end

    reg_8  reg_A (.*, .D(DinA), .Shift_In(A_In), .Load(Ld_A),
	               .Shift_Out(A_out), .Data_Out(A));
    reg_8  reg_B (.*, .D(Din_B), .Shift_In(B_In), .Load(Ld_B),
	               .Shift_Out(B_out), .Data_Out(B));

endmodule
