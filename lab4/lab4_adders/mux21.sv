module mux21 
(
input [3:0] In0,
input [3:0] In1,
input		  Sel,
output [3:0] Out
);
					 
always @ (In0 or In1 or Sel)
	begin	
		case (Sel)
			1'b0     : Out = In0;
			default	: Out = In1;
		endcase
	end
endmodule
