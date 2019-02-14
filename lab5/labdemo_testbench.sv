module labdemo_testbench();
timeunit 10ns; // Half clock cycle at 50 MHz

// This is the amount of time represented by #1
timeprecision 1ns;

logic[7:0] Aval, Bval, Din;
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

// Case 1: 74 x 74 = 3490
Reset = 0;
#4
Reset = 1;
#4
Din = 8'h74;

ClearA_LoadB = 0;
#4
ClearA_LoadB = 1;
#4
Din = 8'h74;

Execute = 0;
#4
Execute = 1;
#4
correct_ans = 16'h3490;
#30
result[15:8] = Aval;
result[7:0] = Bval;
#1

if (result != correct_ans) error++;
$display("%d errors", error); 

// Case 2: 8c x 8c = 3490

Reset = 0;
#4
Reset = 1;
#4
Din = 8'h8c;

ClearA_LoadB = 0;
#4
ClearA_LoadB = 1;
#4
Din = 8'h8c;

Execute = 0;
#4
Execute = 1;
#4
correct_ans = 16'h3490;
#30
result[15:8] = Aval;
result[7:0] = Bval;
#1

if (result != correct_ans) error++;
$display("%d errors", error); 

// Case 3: 8c x 74 = cb70

Reset = 0;
#4
Reset = 1;
#4
Din = 8'h8c;

ClearA_LoadB = 0;
#4
ClearA_LoadB = 1;
#4
Din = 8'h74;

Execute = 0;
#4
Execute = 1;
#4
correct_ans = 16'hcb70;
#30
result[15:8] = Aval;
result[7:0] = Bval;
#1

if (result != correct_ans) error++;
$display("%d errors", error); 

// Case 4: 74 x 8c = cb70

Reset = 0;
#4
Reset = 1;
#4
Din = 8'h74;

ClearA_LoadB = 0;
#4
ClearA_LoadB = 1;
#4
Din = 8'h8c;

Execute = 0;
#4
Execute = 1;
#4
correct_ans = 16'hcb70;
#30
result[15:8] = Aval;
result[7:0] = Bval;
#1

if (result != correct_ans) error++;
$display("%d errors", error); 
end
endmodule
