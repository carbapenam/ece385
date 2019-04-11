module testbench();
timeunit 10ns; // Half clock cycle at 50 MHz

// This is the amount of time represented by #1
timeprecision 1ns;

logic RESET, AES_START, AES_DONE;
logic [127:0] AES_KEY;
logic [127:0] AES_MSG_ENC;
logic [127:0] AES_MSG_DEC;
logic CLK = 0;


// A counter to count the instances where simulation results
// do no match with expected results
integer error = 0;

AES aes_test(.*);

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 CLK = ~CLK;
end

initial begin: CLOCK_INITIALIZATION
CLK = 1;
end

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program

initial begin: TEST_VECTORS

// Case 1: 01 * 01 = 0001

RESET = 0;
#4
RESET = 1;
#4
AES_KEY = 32'h000102030405060708090a0b0c0d0e0f;
AES_MSG_ENC = 32'hdaec3055df058e1c39e814ea76f6747e;

AES_START = 1; 
end

endmodule
