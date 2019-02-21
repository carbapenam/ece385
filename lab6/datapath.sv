module datapath(
/* From the toplevel */
input logic Clk,

/* From the state tachine */
input logic BEN,
input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
input logic GatePC, GateMDR, GateALU, GateMARMUX,
input logic [1:0] PCMUX, ADDR2MUX, ALUK,
input logic DRMUX, SR1MUX, SR2MUX, ADDR1MUX,
input logic MIO_EN,

/* From MEM2IO */
input logic [15:0] MDR_In, /* Alias for Data_from_CPU */

output logic [15:0] MAR, MDR, IR, PC
);

logic [15:0] MDR_MUX_Out, PC_MUX_Out;

//logic [15:0] Modified_Address;

logic [15:0] PC_Plus_1;

//logic [15:0] ALU_Out;

logic [15:0] Bus;

reg_16 REG_MDR(.Clk, .Load(LD_MDR), .Data_In(MDR_MUX_Out), .Data_Out(MDR));
mux2 #(16) MDR_MUX(.D0(Bus), .D1(MDR_In), .Data_Out(MDR_MUX_Out), .S(MIO_EN));

reg_16 REG_MAR(.Clk, .Load(LD_MAR), .Data_In(Bus), .Data_Out(MAR));

reg_16 REG_IR(.Clk, .Load(LD_IR), .Data_In(Bus), .Data_Out(IR));

reg_16 REG_PC(.Clk, .Load(LD_PC), .Data_In(PC_MUX_Out), .Data_Out(PC));
mux4 #(16) PC_MUX(.D0(PC_Plus_1), .D1(/* Modified_Address */), .D2(Bus), .D3(16'h0001), .S(PCMUX), .Data_Out(PC_MUX_Out));

ripple_adder PC_ADDER (.A(PC), .B(16'h0001),. Sum(PC_Plus_1), .Co());

mux_gate #(16) GATE (.D_MARMUX(/* Modified_Address */),
                     .D_PC(PC),
					      .D_ALU(/*ALU_Out*/),
					      .D_MDR(MDR),
					      .Bus(Bus),
					      .S({GateMARMUX, GatePC, GateALU, GateMDR}),
					      .Data_Out(Bus));

endmodule