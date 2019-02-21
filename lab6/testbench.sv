module testbench();
timeunit 10ns;

timeprecision 1ns;

logic [15:0] S;
logic Clk = 0;
logic Reset, Run, Continue;
logic [11:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
logic CE, UB, LB, OE, WE;
logic [19:0] ADDR;
logic [15:0] Data;

lab6_toplevel lab6(
		.S,
		.Clk,
		.Reset,
		.Run,
		.Continue,
		.LED,
		.HEX0,
		.HEX1,
		.HEX2,
		.HEX3,
		.HEX4,
		.HEX5,
		.HEX6,
		.HEX7,
		.CE,
		.UB,
		.LB,
		.OE,
		.WE,
		.ADDR,
		.Data);
		
always begin: CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
Clk = 1;
end



initial begin: TEST_VECTORS

Run = 0;
Continue = 1;

#30

Run = 1;
Continue = 0;

#4

Continue = 1;

#20

Continue = 0;

#4

Continue = 1;

#20

Continue = 0;

#4

Continue = 1;
end

endmodule
