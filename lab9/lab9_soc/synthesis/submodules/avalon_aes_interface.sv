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
endmodule
