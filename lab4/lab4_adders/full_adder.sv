module full_adder(input x,y,z,
                  output s, c);

	assign s = x ^ y;
	assign c = (x & y) | (x & z) | (y & z);

endmodule 						
