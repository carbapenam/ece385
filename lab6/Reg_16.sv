module register 
#(parameter width = 16)

(input logic Clk, Load,
 input  logic [width-1:0]  Data_In,
 output logic [width-1:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
		if (Load) Data_Out <= Data_In;
    end
	

endmodule
