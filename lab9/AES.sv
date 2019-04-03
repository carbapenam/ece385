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

enum logic[4:0] {WAIT, DONE, InvShiftRows, InvMixColumns_0, KeyExpansion,
						AddRoundKey_0, AddRoundKey, InvSubBytes, InvMixColumns_1,
						InvMixColumns_2, InvMixColumns_3} curr_state, next_state;
logic [1407:0] KeySchedule;
logic [127:0] state, RoundKey;
integer round;
logic [31:0] temp;

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
						next_state = InvMixColumns_0;
					else
						next_state = DONE;
				InvMixColumns_0:
						next_state = InvMixColumns_1;
				InvMixColumns_1:
						next_state = InvMixColumns_2;
				InvMixColumns_2:
						next_state = InvMixColumns_3;
				InvMixColumns_3:
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

				end

				AddRoundKey_0:
				begin

				end
				
				AddRoundKey:
				begin

				end
				
				InvShiftRows:
				begin
					
				end
				
				InvSubBytes:
				begin

				end
				
				InvMixColumns_0:
				begin
					round = round - 1;
					temp = state[127:96];
					state[127:96] = temp;
				end
				
				InvMixColumns_1:
				begin
					temp = state[95:64];
					state[95:64] = temp;
				end
				
				InvMixColumns_2:
				begin
					temp = state[63:32];
					state[63:32] = temp;
				end
				
				InvMixColumns_3:
				begin
					temp = state[31:0];
					state[31:0] = temp;
				end
		endcase
	end
	

	
KeyExpansion lab9_KeyExpansion(.clk(CLK), .CipherKey(AES_KEY), .KeySchedule(KeySchedule));	
AddRoundKey lab9_AddRoundKey(.old_state(state), .roundkey(KeySchedule[128*round +: 128]), .new_state(state));
InvShiftRows lab9_InvShiftRows(.data_in(state), .data_out(state));
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
InvMixColumns lab9_InvMixColumns0(.data_in(temp), .data_out(temp));			
 
endmodule



