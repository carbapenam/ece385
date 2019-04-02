module InvAddRoundKey (
	input logic [127:0] old_state,
	input logic [127:0] roundkey,
	output logic [127:0] new_state
);

//wow, this is filthy.

assign new_state[7:0] = old_state[7:0] ^ roundkey[31:24];
assign new_state[39:32] = old_state[39:32] ^ roundkey[23:16];
assign new_state[71:64] = old_state[71:64] ^ roundkey[15:8];
assign new_state[103:96] = old_state[103:96] ^ roundkey[7:0];

assign new_state[15:8] = old_state[15:8] ^ roundkey[63:56];
assign new_state[47:40] = old_state[47:40] ^ roundkey[55:48];
assign new_state[79:72] = old_state[79:72] ^ roundkey[47:40];
assign new_state[111:104] = old_state[111:104] ^ roundkey[39:32];

assign new_state[23:16] = old_state[23:16] ^ roundkey[95:88];
assign new_state[55:48] = old_state[55:48] ^ roundkey[87:80];
assign new_state[87:80] = old_state[87:80] ^ roundkey[79:72];
assign new_state[119:112] = old_state[119:112] ^ roundkey[71:64];

assign new_state[31:24] = old_state[31:24] ^ roundkey[127:120];
assign new_state[63:56] = old_state[63:56] ^ roundkey[119:112];
assign new_state[95:88] = old_state[95:88] ^ roundkey[111:104];
assign new_state[127:120] = old_state[127:120] ^ roundkey[103:96];

endmodule
