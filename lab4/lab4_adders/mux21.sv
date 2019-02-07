module mux21_4bit
(
input logic  [3:0] In0,
input logic  [3:0] In1,
input	logic	       Sel,
output logic [3:0] Out
);
					 
always_comb
	begin	
		case (Sel)
			1'b0     : Out = In0;
			default	: Out = In1;
		endcase
	end
endmodule

module mux21_1bit
(
input logic In0, In1, Sel,
output logic Out
);
					 
always_comb
	begin	
		case (Sel)
			1'b0     : Out = In0;
			default	: Out = In1;
		endcase
	end
endmodule