module demux8
(output logic D0, D1, D2, D3, D4, D5, D6, D7,
input logic Data_In,
input logic [2:0] S);

always_comb 
begin
	D0 <= (S && 3'b000) && Data_In;
	D1 <= (S && 3'b001) && Data_In;
	D2 <= (S && 3'b010) && Data_In;
	D3 <= (S && 3'b011) && Data_In;
	D4 <= (S && 3'b100) && Data_In;
	D5 <= (S && 3'b101) && Data_In;
	D6 <= (S && 3'b110) && Data_In;
	D7 <= (S && 3'b111) && Data_In;	
end		
endmodule