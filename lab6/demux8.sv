module demux8
(output logic D0, D1, D2, D3, D4, D5, D6, D7,
input logic Data_In,
input logic [2:0] S,

logic[2:0] value = 8'h00;
assign D0 <= value[0];
assign D1 <= value[1];
assign D2 <= value[2];
assign D3 <= value[3];
assign D4 <= value[4];
assign D5 <= value[5];
assign D6 <= value[6];
assign D7 <= value[7];



always_comb begin
		case (S)
			3'b000:
				Data_Out = Data_In;
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