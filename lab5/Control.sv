//Two-always example for state machine

module control (input  logic Clk, Reset, ClearA_LoadB, Execute, M0,
                output logic Shift_En, Ld_X, Ld_A, Ld_B, fn, ClearA, 
					 output logic[4:0] debug);

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [4:0] {Start, Clear, A0, S0, A1, S1, A2, S2, A3, S3, A4, S4, A5, S5, A6, S6, SUB7, S7, Finish} curr_state, next_state; 
	
	 assign debug = curr_state;
	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk or posedge Reset)  
    begin
        if (Reset)
            curr_state = Start;
        else 
            curr_state = next_state;
    end

    // Assign outputs based on state
	always_comb
    begin        
		  next_state = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 
            Start : if (Execute)
                    next_state = Clear;
			   Clear:  next_state = A0;
				A0 :    next_state = S0;
            S0 :    next_state = A1;
            A1 :    next_state = S1;
				S1 :	  next_state = A2;
				A2 :	  next_state = S2;
				S2 :	  next_state = A3;
				A3 :	  next_state = S3;				
            S3 :    next_state = A4;
            A4 :    next_state = S4;
				S4 :    next_state = A5;
				A5 :    next_state = S5;
				S5 :    next_state = A6;
				A6 :    next_state = S6;
				S6 :    next_state = SUB7;
				SUB7 :  next_state = S7;
				S7 :    next_state = Finish;
            Finish :   if (~Execute) 
                       next_state = Start;
							  
        endcase
  end
 
always_comb
begin 
		  // Assign outputs based on ‘state’
        unique case (curr_state) 
				Start:  //starting state
				begin
					 fn <= 1'b0;
					 ClearA <= ClearA_LoadB;
					 Ld_A <= 1'b0;
					 Ld_B <= ClearA_LoadB;
					 Ld_X <= 1'b0;
					 Shift_En <= 1'b0;
				end

				Clear:  //starting state
				begin
					 fn <= 1'b0;
					 ClearA <= 1'b1;
					 Ld_A <= 1'b0;
					 Ld_B <= 1'b0;
					 Ld_X <= 1'b0;
					 Shift_En <= 1'b0;
				end				
				
				Finish:  // end state, idle
		      begin
                fn <= 1'b0;				
                Ld_A <= 1'b0;
					 Ld_X <= 1'b0;
                Ld_B <= 1'b0;
					 ClearA <= 1'b0;
                Shift_En <= 1'b0;
		      end

				A0,A1,A2,A3,A4,A5,A6:
				begin
					 Ld_A <= M0;
					 Ld_X <= M0;
					 Ld_B <= 1'b0;
					 Shift_En <= 1'b0;
					 fn <= 1'b0;
					 ClearA <= 1'b0;
				end

				SUB7:   //last operation, sub instead of add
				begin
					 fn <= 1'b1;
					 Ld_X <= M0;
					 Ld_A <= M0;
					 Ld_B <= 1'b0;
					 Shift_En <= 1'b0;
					 ClearA <= 1'b0;
				end
				
	   	   S0,S1,S2,S3,S4,S5,S6:  //all other cases, just shift
		      begin 
					 fn <= 1'b0;
					 Ld_X <= 1'b0;
				    Ld_A <= 1'b0;
                Ld_B <= 1'b0;
                Shift_En <= 1'b1;
					 ClearA <= 1'b0;
		      end
				
				S7:
		      begin 
					 fn <= 1'b1;
					 Ld_X <= 1'b0;
				    Ld_A <= 1'b0;
                Ld_B <= 1'b0;
                Shift_En <= 1'b1;
					 ClearA <= 1'b0;
		      end
        endcase
    end

endmodule
