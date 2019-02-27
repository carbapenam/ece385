module alu(input logic [1:0] ALUK,
           input logic [15:0] B, A,
			  output logic [15:0] Data_Out);

logic [15:0] Sum;
			  
ripple_adder ADDER (.A, 
                    .B,
						  .Sum, 
						  .Co()
						  );	
always_comb begin 
	case (ALUK)
		2'b00:
			Data_Out = Sum;
		2'b01:
			Data_Out = A & B;
		2'b10:
			Data_Out = ~A;
		2'b11:
			Data_Out = A;
	endcase
end
endmodule