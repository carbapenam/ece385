/************************************************************************
AES Decryption Core Logic

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

module AES (
	input	 logic CLK,
	input  logic RESET,
	input  logic AES_START,
	output logic AES_DONE,
	input  logic [127:0] AES_KEY,
	input  logic [127:0] AES_MSG_ENC,
	output logic [127:0] AES_MSG_DEC
);

enum logic[1:0] {WAIT, DONE, InvShiftRows, InvMixColumns, KeyExpansion,
						AddRoundKey_0, AddRoundKey, InvSubBytes} curr_state, next_state;
logic [1407:0] KeySchdule;
logic [127:0] state, RoundKey;
logic [3:0] round;


always_ff @ (posedge CLK or posedge RESET)  
    begin
        if (RESET)
            curr_state = WAIT;
        else 
            curr_state = next_state;
    end
	 
always_comb
    begin        
		  next_state = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 
            WAIT : if (AES_START)
							next_state = KeyExpansion;
						 else 
							next_state = WAIT;
			   DONE:  if (AES_START)
							next_state = DONE;
						 else 
							next_state = WAIT;
							
				//internal loop states
				KeyExpansion:
					next_state = AddRoundKey_0;
				AddRoundKey_0 :    
					next_state = InvShiftRows;
				InvShiftRows: 		 
					next_state = InvSubBytes;
            InvSubBytes:    
					next_state = AddRoundKey;
				AddRoundKey:
					if (round > 0)
						next_state = InvMixColumns;
					else
						next_state = DONE;
				InvMixColumns:
						next_state = InvShiftRows;
        endcase
	 end
	 
always_comb
	begin 
		  // Assign outputs based on ‘state’
        unique case (curr_state) 
				WAIT:  //starting state
				begin
					AES_DONE = 1'b0;
					round = 4'b1001;  //count down from 9 to 1
					state = AES_MSG_ENC;
				end

				DONE:  //starting state
				begin
					AES_DONE = 1'b1;
					AES_MSG_DEC = state;
				end		
		
				KeyExpansion:
				begin
					KeyExpansion lab9_KeyExpansion(.clk(CLK), .CipherKey(AES_KEY), .KeySchedule);
				end

				AddRoundKey_0:
				begin
					AddRoundKey lab9_AddRoundKey(.*);
				end
				
				AddRoundKey:
				begin
					AddRoundKey lab9_AddRoundKey(.*);
				end
				
				InvShiftRows:
				begin
					InvShiftRows lab9_InvShiftRows(.data_in(state), .data_out(state));
				end
				
				InvSubBytes:
				begin
					InvSubBytes lab9_InvSubBytes0(.clk(CLK), .in(state[7:0]), .out(state[7:0]));
					InvSubBytes lab9_InvSubBytes1(.clk(CLK), .in(state[15:8]), .out(state[15:8]));
					InvSubBytes lab9_InvSubBytes2(.clk(CLK), .in(state[23:16]), .out(state[23:16]));
					InvSubBytes lab9_InvSubBytes3(.clk(CLK), .in(state[31:24]), .out(state[31:24]));
					InvSubBytes lab9_InvSubBytes4(.clk(CLK), .in(state[39:32]), .out(state[39:32]));
					InvSubBytes lab9_InvSubBytes5(.clk(CLK), .in(state[47:40]), .out(state[47:40]));
					InvSubBytes lab9_InvSubBytes6(.clk(CLK), .in(state[53:48]), .out(state[53:48]));
					InvSubBytes lab9_InvSubBytes7(.clk(CLK), .in(state[62:54]), .out(state[62:54]));
					InvSubBytes lab9_InvSubBytes8(.clk(CLK), .in(state[71:63]), .out(state[71:63]));
					InvSubBytes lab9_InvSubBytes9(.clk(CLK), .in(state[79:72]), .out(state[79:72]));
					InvSubBytes lab9_InvSubBytes10(.clk(CLK), .in(state[87:80]), .out(state[87:80]));
					InvSubBytes lab9_InvSubBytes11(.clk(CLK), .in(state[95:88]), .out(state[95:88]));
					InvSubBytes lab9_InvSubBytes12(.clk(CLK), .in(state[103:96]), .out(state[103:96]));
					InvSubBytes lab9_InvSubBytes13(.clk(CLK), .in(state[111:104]), .out(state[111:104]));
					InvSubBytes lab9_InvSubBytes14(.clk(CLK), .in(state[119:112]), .out(state[119:112]));
					InvSubBytes lab9_InvSubBytes15(.clk(CLK), .in(state[127:120]), .out(state[127:120]));
				end
				
				InvMixColumns:
				begin
					round = round - 1;
					InvMixColumns lab9_InvMixColumns0(.data_in(state[31:0]), .data_out(state[31:0]);
					InvMixColumns lab9_InvMixColumns1(.data_in(state[63:32]), .data_out(state[63:32]);
					InvMixColumns lab9_InvMixColumns2(.data_in(state[95:64]), .data_out(state[95:64]);
					InvMixColumns lab9_InvMixColumns3(.data_in(state[127:96]), .data_out(state[127:96]);
				end
		endcase
	end
					
	 
endmodule



