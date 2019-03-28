/************************************************************************
Avalon-MM Interface for AES Decryption IP Core

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department

Register Map:

 0-3 : 4x 32bit AES Key
 4-7 : 4x 32bit AES Encrypted Message
 8-11: 4x 32bit AES Decrypted Message
   12: Not Used
	13: Not Used
   14: 32bit Start Register
   15: 32bit Done Register

************************************************************************/

module avalon_aes_interface (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Exported Conduit
	output logic [31:0] EXPORT_DATA		// Exported Conduit Signal to LEDs
);


/*
logic [31:0] AES_KEY0, AES_KEY1, AES_KEY2, AES_KEY3;
logic [31:0] AES_MSG_EN0, AES_MSG_EN1, AES_MSG_EN2, AES_MSG_EN3;
logic [31:0] AES_MSG_DE0, AES_MSG_DE1, AES_MSG_DE2, AES_MSG_DE3;
logic [31:0] AES_START, AES_DONE;

AES AES_unit(*, .AES_KEY(AES_KEY3, AES_KEY2, AES_KEY1, AES_KEY0), 
.AES_MSG_ENC(AES_MSG_EN3, AES_MSG_EN2, AES_MSG_EN1, AES_MSG_EN0), 
.AES_MSG_DEC(AES_MSG_DE3, AES_MSG_DE2, AES_MSG_DE1, AES_MSG_DE0),
.AES_Start, .AES_DONE);*/

logic [31:0] registers[16];

always_comb
begin
	if (RESET)
	begin
		for (int i=0; i<16; i++)
		begin
			registers[16] = 32'b0;
		end
	end

	if (AVL_CS)
	begin
		if (AVL_WRITE)
		begin
			if (AVL_BYTE_EN[0] == 1'b0)
			begin
				registers[AVL_ADDR][7:0] <= AVL_WRITEDATA[7:0];
			end
			
			if (AVL_BYTE_EN[1] == 1'b0)
			begin
				registers[AVL_ADDR][15:8] <= AVL_WRITEDATA[15:8];
			end
			
			if (AVL_BYTE_EN[2] == 1'b0)
			begin
				registers[AVL_ADDR][23:16] <= AVL_WRITEDATA[23:16];
			end

			if (AVL_BYTE_EN[3] == 1'b0)
			begin
				registers[AVL_ADDR][31:24] <= AVL_WRITEDATA[31:24];
			end
		end
		
		if (AVL_READ)
		begin
			assign AVL_READDATA = register[AVL_ADDR];
		end
	end
end

// EXPORT_DATA assigned to the first 2 and last 2 bytes of the Encrypted Message
assign EXPORT_DATA = {registers[7][31:24], registers[4][15:0]};

/*
Reg_32 AES_KEY0(*, .D(AES_KEY[31:0]));
Reg_32 AES_KEY1(*, .D(AES_KEY[63:32]));
Reg_32 AES_KEY2(*, .D(AES_KEY[95:64]));
Reg_32 AES_KEY3(*, .D(AES_KEY[127:96]));
Reg_32 AES_MSG_EN0(*, .D(AES_MSG_ENC[31:0]));
Reg_32 AES_MSG_EN1(*, .D(AES_MSG_ENC[63:32]));
Reg_32 AES_MSG_EN2(*, .D(AES_MSG_ENC[95:64]));
Reg_32 AES_MSG_EN3(*, .D(AES_MSG_ENC[127:96]));
Reg_32 AES_MSG_DE0(*, .D(AES_MSG_DEC[31:0]));
Reg_32 AES_MSG_DE1(*, .D(AES_MSG_DEC[63:32]));
Reg_32 AES_MSG_DE2(*, .D(AES_MSG_DEC[95:64]));
Reg_32 AES_MSG_DE3(*, .D(AES_MSG_DEC[127:96]));
Reg_32 AES_START(*, .D(AES_START));
Reg_32 AES_DONE(*, .Data_Out(AES_DONE));
*/

endmodule
