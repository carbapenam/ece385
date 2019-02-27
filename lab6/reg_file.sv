module reg_file
(input logic [2:0] DR, SR2, SR1,
 input logic LD_REG, Clk,
 input logic [15:0] Data_In,
 output logic [15:0] SR1_Out, SR2_Out
);

logic LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
wire [15:0] R0_Out, R1_Out, R2_Out, R3_Out, R4_Out, R5_Out, R6_Out, R7_Out;

demux8 MUX_REG(.D0(LD0),
               .D1(LD1),
					.D2(LD2),
					.D3(LD3),
					.D4(LD4),
					.D5(LD5),
					.D6(LD6),
					.D7(LD7),
					.S(DR),
					.Data_In(LD_REG));

register #(16) R0 (.Clk, .Load(LD0), .Data_In, .Data_Out(R0_Out));					
register #(16) R1 (.Clk, .Load(LD1), .Data_In, .Data_Out(R1_Out));
register #(16) R2 (.Clk, .Load(LD2), .Data_In, .Data_Out(R2_Out));
register #(16) R3 (.Clk, .Load(LD3), .Data_In, .Data_Out(R3_Out));
register #(16) R4 (.Clk, .Load(LD4), .Data_In, .Data_Out(R4_Out));
register #(16) R5 (.Clk, .Load(LD5), .Data_In, .Data_Out(R5_Out));
register #(16) R6 (.Clk, .Load(LD6), .Data_In, .Data_Out(R6_Out));
register #(16) R7 (.Clk, .Load(LD7), .Data_In, .Data_Out(R7_Out));

mux8 #(16) MUX_SR2(.D0(R0_Out),
                   .D1(R1_Out),
					    .D2(R2_Out),
					    .D3(R3_Out),
					    .D4(R4_Out),
					    .D5(R5_Out),
					    .D6(R6_Out),
					    .D7(R7_Out),
					    .S(SR2),
					    .Data_Out(SR2_Out));
						 
// Don't get confused. This is not SR1MUX. SR1MUX is connected outside of REG FILE.
mux8 #(16) MUX_SR1(.D0(R0_Out),
                   .D1(R1_Out),
					    .D2(R2_Out),
					    .D3(R3_Out),
					    .D4(R4_Out),
					    .D5(R5_Out),
					    .D6(R6_Out),
					    .D7(R7_Out),
					    .S(SR1),
					    .Data_Out(SR1_Out));

endmodule
