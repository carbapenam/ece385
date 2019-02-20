module reg_16 (input logic Clk, Load,
              input  logic [15:0]  Data_In,
              output logic [15:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
		if (Load) Data_Out <= Data_In;
    end
	

endmodule
