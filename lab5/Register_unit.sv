module register_unit (input  logic Clk, Reset, A_In, B_In, Ld_A, Ld_B, 
									 Clear_A, Shift_En, Ld_X,
                      input  logic [7:0]  Din_A,
							 input  logic [7:0]	Din_B, 
							 input  logic		X_new,
							 input  logic     X_prev,
                      output logic A_out, B_out, 
                      output logic [7:0]  A,
							 output logic  	X,
							 output logic [7:0]  debug4,
                      output logic [7:0]  B);
							 
logic [7:0] Modified_A;
							 
always_ff @ (negedge Clk)  
   begin
	if (Clear_A)
		Modified_A <= 8'h0;
	else 
		Modified_A <= Din_A;
	end

always_ff @ (negedge Clk)  
   begin
	if (Ld_X)
		X <= X_new;
	else 
		X <= X_prev;
	end

	assign debug4 = Modified_A;
	
    reg_8  reg_A (.Clk(Clk), .Reset(Reset), .Shift_En(Shift_En),
						.D(Modified_A), .Shift_In(A_In), .Load(Ld_A),
	               .Shift_Out(A_out), .Data_Out(A));
    reg_8  reg_B (.*, .D(Din_B), .Shift_In(B_In), .Load(Ld_B),
	               .Shift_Out(B_out), .Data_Out(B));

endmodule
