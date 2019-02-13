//Two-always example for state machine

module control (input  logic Clk, Reset, ClearA_LoadB, Execute, M0,
                output logic Shift_En, Ld_A, Ld_B, fn, ClearA );

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [4:0] {S, A, B, C,  D, E, F, G,  H, I, J, K,  L, M, N, O,  P, Q}   curr_state, next_state; 

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= S;
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_ff @ (posedge Clk) 
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            S :    if (Execute)
                       next_state = A;
				A :    next_state = B;
            B :    next_state = C;
            C :    next_state = D;
				D :	 next_state = E;
				E :	 next_state = F;
				F :	 next_state = G;
				G :	 next_state = H;				
            H :    next_state = I;
            I :    next_state = J;
				J :    next_state = K;
				K :    next_state = L;
				L :    next_state = M;
				M :    next_state = N;
				N :    next_state = O;
				O :    next_state = P;
				P :    next_state = Q;
            Q :    if (~Execute) 
                       next_state = A;
							  
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
				S:  //starting state
				begin
					 fn = 1'b0;
					 ClearA = ClearA_LoadB;
					 Ld_A = 1'b0;
					 Ld_B = ClearA_LoadB;
					 Shift_En = 1'b0;
				end
				Q:  // end state, idle
		      begin
                Ld_A = 1'b0;
                Ld_B = 1'b0;
					 ClearA = 1'b0;
                Shift_En = 1'b0;
		      end
	   	   A: // 1st add
	         begin
					 fn = 1'b0;
                Ld_A = M0;
                Ld_B = 1'b0;
					 ClearA = 1'b0;
                Shift_En = 1'b0;
		      end

				C:  //2nd add
				begin
					 Ld_A = M0;
					 Ld_B = 1'b0;
					 Shift_En = 1'b0;
					 fn = 1'b0;
					 ClearA = 1'b0;
				end
			   E:  //3rd add
				begin
					 Ld_A = M0;
					 Ld_B = 1'b0;
					 Shift_En = 1'b0;
					 fn = 1'b0;
					 ClearA = 1'b0;
				end
				G:   //4th add
				begin
					 Ld_A = M0;
					 Ld_B = 1'b0;
					 Shift_En = 1'b0;
					 fn = 1'b0;
					 ClearA = 1'b0;
				end
				I:    //5th add
				begin
					 Ld_A = M0;
					 Ld_B = 1'b0;
					 Shift_En = 1'b0;
					 fn = 1'b0;
					 ClearA = 1'b0;
				end
				K:   //6th add
				begin
					 Ld_A = M0;
					 Ld_B = 1'b0;
					 Shift_En = 1'b0;
					 fn = 1'b0;
					 ClearA = 1'b0;
				end
				M:    //7th add
				begin
					 Ld_A = M0;
					 Ld_B = 1'b0;
					 Shift_En = 1'b0;
					 fn = 1'b0;
					 ClearA = 1'b0;
				end
				O:   //last operation, sub instead of add
				begin
					 fn = 1'b1;
					 Ld_A = M0;
					 Ld_B = 1'b0;
					 Shift_En = 1'b0;
					 ClearA = 1'b0;
				end
	   	   default:  //all other cases, just shift
		      begin 
                Ld_A = 1'b0;
                Ld_B = 1'b0;
                Shift_En = 1'b1;
					 ClearA = 1'b0;
		      end
        endcase
    end

endmodule
