module datapath(
/* From the toplevel */
input logic Clk,
input logic Reset,

/* From the state tachine */
output logic BEN,
input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
input logic GatePC, GateMDR, GateALU, GateMARMUX,
input logic [1:0] PCMUX, ADDR2MUX, ALUK,
input logic DRMUX, SR1MUX, SR2MUX, ADDR1MUX,
input logic MIO_EN,
input logic REG_Reset,

/* From MEM2IO */
input logic [15:0] MDR_In, /* Alias for Data_from_CPU */
output logic [15:0] MAR, MDR, IR, PC
);

// Variables for top left datapath

logic [15:0] Modified_Address;
logic [15:0] PC_Plus_1, PC_Plus_1_Synced, MUX_PC_Out;
logic [15:0] MUX_ADDR1_Out, MUX_ADDR2_Out;

// Variables for top right datapath
logic [2:0] MUX_DR_Out, MUX_SR1_Out; 
logic [15:0] MUX_SR2_Out;
logic [15:0] SR1_Out, SR2_Out;
logic [15:0] ALU_Out;

// Variables for middle branching section

logic [2:0] REG_NZP_Out;
logic test;

// Variables for bottom datapath

logic [15:0] MUX_MDR_Out;


logic [15:0] Bus;

register #(16) REG_MDR(.Clk, .Load(LD_MDR), .Data_In(MUX_MDR_Out), .Data_Out(MDR), .REG_Reset);
mux2 #(16) MUX_MDR(.D0(Bus), .D1(MDR_In), .Data_Out(MUX_MDR_Out), .S(MIO_EN));

register #(16) REG_MAR(.Clk, .Load(LD_MAR), .Data_In(Bus), .Data_Out(MAR), .REG_Reset);

register #(16) REG_IR(.Clk, .Load(LD_IR), .Data_In(Bus), .Data_Out(IR), .REG_Reset);

register #(16) REG_PC(.Clk, .Load(LD_PC), .Data_In(MUX_PC_Out), .Data_Out(PC), .REG_Reset);
mux4 #(16) MUX_PC(.D0(PC_Plus_1_Synced), 
                  .D1(Modified_Address), 
						.D2(Bus),
						.D3(16'h0001),
						.S(PCMUX),
						.Data_Out(MUX_PC_Out));

ripple_adder PC_ADDER (.A(PC), .B(16'h0001),. Sum(PC_Plus_1), .Co());
sync16 SYNC_PC_ADDER(Clk, PC_Plus_1, PC_Plus_1_Synced);


mux4 #(16) MUX_ADDR2(.D0(16'h0000), 
                     .D1({ {10{IR[5]}}, IR[5:0]}),
							.D2({ {7{IR[8]}}, IR[8:0]}),
							.D3({ {5{IR[10]}}, IR[10:0]}),
							.S(ADDR2MUX),
							.Data_Out(MUX_ADDR2_Out)
							);

mux2 #(16) MUX_ADDR1(.D0(PC),
                     .D1(SR1_Out),
							.S(ADDR1MUX),
							.Data_Out(MUX_ADDR1_Out)
							);
							
ripple_adder ADDER_MARMUX (.A(MUX_ADDR1_Out), 
                           .B(MUX_ADDR2_Out),
									.Sum(Modified_Address), 
									.Co()
								  );

//Components for right side of datapath								  

mux2 #(3) MUX_DR(.D0(3'b111),
                  .D1(IR[11:9]),
					   .S(DRMUX),
					   .Data_Out(MUX_DR_Out)
					  );
					  
mux2 #(3) MUX_SR1(.D0(IR[11:9]),
                  .D1(IR[8:6]),
					   .S(SR1MUX),
					   .Data_Out(MUX_SR1_Out)
					  );

					  
reg_file REG_FILE(.DR(MUX_DR_Out),
                  .SR1(MUX_SR1_Out),
						.SR2(IR[2:0]),
						.Data_In(Bus),
                  .SR1_Out, 
						.SR2_Out,
						.Clk,
						.LD_REG,
						.REG_Reset);
						
mux2 #(16) MUX_SR2(.D0(SR2_Out),
                   .D1({ {11{IR[4]}}, IR[4:0]}),
	                .S(SR2MUX),
	                .Data_Out(MUX_SR2_Out)
	               );
						
alu ALU(.B(MUX_SR2_Out),
        .A(SR1_Out),
		  .ALUK,
		  .Data_Out(ALU_Out)
		 );
		 
// Center branching section

register #(3) REG_NZP(.Data_In({(Bus[15] == 1'b0),
                                (Bus[15:0] == 16'h0000),
										  (Bus[15] == 1'b1)}), 
							 .Load (LD_CC),
							 .Clk,
							 .Data_Out(REG_NZP_Out),
							 .REG_Reset
							 );

assign test = ((IR[11] & REG_NZP_Out[2]) | (IR[10] & REG_NZP_Out[1]) | (IR[9] & REG_NZP_Out[0]));
							 
reg1 REG_BEN(.Data_In(test), 
							 .Load (LD_BEN),
							 .Clk,
							 .Data_Out(BEN),
							 .REG_Reset
							 );
							 
		 
mux_gate #(16) GATE (.D_MARMUX(Modified_Address),
                     .D_PC(PC),
					      .D_ALU(ALU_Out),
					      .D_MDR(MDR),
					      .Bus(Bus),
					      .S({GateMARMUX, GatePC, GateALU, GateMDR}),
							.Data_Out(Bus));

							
endmodule