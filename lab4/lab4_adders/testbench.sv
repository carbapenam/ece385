module testbench();
timeunit 10ns; // Half clock cycle at 50 MHz

// This is the amount of time represented by #1
timeprecision 1ns;

logic[15:0] A, B, result_cla, result_ra, result_csa;
logic[15:0] correct_ans;
logic ra_co, cla_co, csa_co;
logic Clk = 0;

// A counter to count the instances where simulation results
// do no match with expected results
integer ra_error = 0;
integer cla_error = 0;
integer csa_error = 0;

ripple_adder ripple_adder_inst
(
        .A,             // This is shorthand for .A(A) when both wires/registers have the same name
        .B,
        .Sum(result_ra), // Connects the Sum_comb wire in this file to the Sum wire in ripple_adder.sv
        .Co(ra_co)
);
	 
    carry_lookahead_adder hello
    (
        .A,             // This is shorthand for .A(A) when both wires/registers have the same name
        .B,
        .Sum(result_cla), // Connects the Sum_comb wire in this file to the Sum wire in ripple_adder.sv
        .Co(cla_co)
    );

    carry_select_adder stf
    (
        .A,             // This is shorthand for .A(A) when both wires/registers have the same name
        .B,
        .Sum(result_csa), // Connects the Sum_comb wire in this file to the Sum wire in ripple_adder.sv
        .Co(csa_co)
    );

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end
initial begin: CLOCK_INITIALIZATION
Clk = 0;
end

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program

initial begin: TEST_VECTORS

// Case 1: CAFE+0666 = D164
#2 A = 16'hCAFE;
#2 B = 16'h0666;
correct_ans = 16'hD164;
#42 //Delay 42ns.

if (result_ra != correct_ans) ra_error++;
if (result_cla != correct_ans) cla_error++;
if (result_csa != correct_ans) csa_error++;

// Case 2: babe+69 = BB27
#2 A = 16'hBABE;
#2 B = 16'h0069;
correct_ans = 16'hBB27;
#42 //Delay 42ns.

if (result_ra != correct_ans) ra_error++;
if (result_cla != correct_ans) cla_error++;
if (result_csa != correct_ans) csa_error++;

// Case 3: 420+6969 = 6D89
#2 A = 16'h0420;
#2 B = 16'h6969;
correct_ans = 16'h6D89;
#42 //Delay 42ns.

if (result_ra != correct_ans) ra_error++;
if (result_cla != correct_ans) cla_error++;
if (result_csa != correct_ans) csa_error++;

// Case 4: CAFE+BABE = 185BC
#2 A = 16'h0420;
#2 B = 16'h6969;
correct_ans = 16'h85BC;
#42 //Delay 42ns.

if (result_ra != correct_ans) ra_error++;
if (result_cla != correct_ans) cla_error++;
if (result_csa != correct_ans) csa_error++;

$display("RA: %d errors", ra_error);
$display("CLA: %d errors", cla_error);
$display("CSA: %d errors", csa_error);

end
endmodule
