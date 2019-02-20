module mux2
	#(parameter width = 16)
		(input logic [width-1:0] D0, D1,
		 input logic S,
		 output logic [width-1:0] Data_Out);
	always_comb begin
		if (S)
			Data_Out = D1;
		else
			Data_Out = D0;
	end
		
endmodule

module mux4
	#(parameter width = 16)
		(input logic [width-1:0] D0, D1, D2, D3,
		 input logic [1:0] S,
		 output logic [width-1:0] Data_Out);
	always_comb begin
		case (S)
			2'b00:
				Data_Out = D0;
			2'b01:
				Data_Out = D1;
			2'b10:
				Data_Out = D2;
			2'b11:
				Data_Out = D3;
			endcase
		end
		
endmodule

module mux8
	#(parameter width = 16)
		(input logic [width-1:0] D0, D1, D2, D3, D4, D5, D6, D7,
		 input logic [2:0] S,
		 output logic [width-1:0] Data_Out);
	always_comb begin
		case (S)
			3'b000:
				Data_Out = D0;
			3'b001:
				Data_Out = D1;
			3'b010:
				Data_Out = D2;
			3'b011:
				Data_Out = D3;
			3'b100:
				Data_Out = D4;
			3'b101:
				Data_Out = D5;
			3'b110:
				Data_Out = D6;
			3'b111:
				Data_Out = D7;
				endcase
		end
		
endmodule

module mux_gate
	#(parameter width = 16)
		(input logic [width-1:0] D_MARMUX, D_PC, D_ALU, D_MDR, Bus,
		 input logic [3:0] S,
		 output logic [width-1:0] Data_Out);
	always_comb begin
		case (S)
			4'b1000:
				Data_Out = D_MARMUX;
			4'b0100:
				Data_Out = D_PC;
			4'b0010:
				Data_Out = D_ALU;
			4'b0001:
				Data_Out = D_MDR;
			default:
				Data_Out = Bus;
			endcase
		end
endmodule
