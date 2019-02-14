module testbench();
timeunit 10ns; // Half clock cycle at 50 MHz

// This is the amount of time represented by #1
timeprecision 1ns;

logic[7:0] A_in, B_in, Aval, Bval, Din;
logic[15:0] result, correct_ans;
logic[4:0] debug;
logic Clk = 0;
logic Reset, ClearA_LoadB, Execute, X, AhexL, AhexU, BhexL, BhexU;

// A counter to count the instances where simulation results
// do no match with expected results
integer error = 0;

Processor proc(.Clk,
					.Reset,
					.ClearA_LoadB,
					.Execute,
					.Din,
					.X,
					.Aval,
					.Bval,
					.debug,
               .AhexL(), 
					.AhexU(),
					.BhexL(),
					.BhexU());

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
Clk = 1;
end

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program

initial begin: TEST_VECTORS

// Case 1: 01 * 01 = 0001
A_in = 8'h01;
B_in = 8'h01;
Reset = 0;
#4
Reset = 1;
#4
Din = B_in;

ClearA_LoadB = 0;
#4
ClearA_LoadB = 1;
#4
Din = A_in;

Execute = 0;
#4
Execute = 1;
#4
correct_ans = 16'h0001;
#30
result[15:8] = Aval;
result[7:0] = Bval;
#1

if (result != correct_ans) error++;
$display("%d errors", error);
#1 


// Case 2: 01 * -01 = -0001
A_in = 8'h01;
B_in = -8'h01;
Reset = 0;
#4
Reset = 1;
#4
Din = B_in;

ClearA_LoadB = 0;
#4
ClearA_LoadB = 1;
#4
Din = A_in;

Execute = 0;
#4
Execute = 1;
#4
correct_ans = -16'h0001;
#30
result[15:8] = Aval;
result[7:0] = Bval;
#1

if (result != correct_ans) error++;
$display("%d errors", error);
#1 

// Case 3: -01 * -01 = 0001
A_in = -8'h01;
B_in = -8'h01;
Reset = 0;
#4
Reset = 1;
#4
Din = B_in;

ClearA_LoadB = 0;
#4
ClearA_LoadB = 1;
#4
Din = A_in;

Execute = 0;
#4
Execute = 1;
#4
correct_ans = 16'h0001;
#30
result[15:8] = Aval;
result[7:0] = Bval;
#1
if (result != correct_ans) error++;
$display("%d errors", error);

// Case 4: CA * FE = C86C
A_in = 8'hCA;
B_in = 8'hFE;
Reset = 0;
#4
Reset = 1;
#4
Din = B_in;

ClearA_LoadB = 0;
#4
ClearA_LoadB = 1;
#4
Din = A_in;

Execute = 0;
#4
Execute = 1;
#4
correct_ans = 16'hC86C;
#30
result[15:8] = Aval;
result[7:0] = Bval;
#1

if (result != correct_ans) error++;
$display("%d errors", error);
end

endmodule
