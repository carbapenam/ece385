module datapath(
	//input logic[15:0] S,
);

logic BEN;
logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED;
logic GatePC, GateMDR, GateALU, GateMARMUX;
logic [1:0] PCMUX, ADDR2MUX, ALUK;
logic DRMUX, SR1MUX, SR2MUX, ADDR1MUX;
logic MIO_EN;

logic [15:0] MDR_In;
logic [15:0] MAR, MDR, IR, PC;
logic [15:0] Data_from_SRAM, Data_to_SRAM;


logic [15:0] MDR_MUX_Out, PC_MUX_Out

//logic [15:0] Modified_Address
//logic [15:0] PC_Plus_1

reg_16 REG_MDR(.Clk, .Load(LD_MDR), Data_In(MDR_MUX_Out), Data_Out(MDR))
mux2 #(16) MDR_MUX(.D0(Bus), .D1(MDR_In), .Data_Out(MDR_Mux_Out))

reg_16 REG_MAR(.Clk, .Load(LD_MAR), Data_In(Bus), Data_Out(MAR))

reg_16 REG_IR(.Clk, .Load(LD_IR), Data_In(Bus), Data_Out(IR))

reg_16 REG_PC(.Clk, .Load(LD_PC), Data_In(PC_MUX_Out), Data_Out(PC))
mux4 #(16) PC_MUX(.D0(Bus), .D1(/*Modified_Address*/), .D2(/*PC_Plus_1*/), .D3(0))



endmodule