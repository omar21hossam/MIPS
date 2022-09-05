//-----------------------------------------------------------------------

// Module: Sign Extend

// File Name: Sign Extend.V

// Description: Sign extension simply copies the sign bit (most significant bit) of a short input (16 bits) 

// into all of the upper bits of the longer output (32 bits).

// Author: Omar Hossam El Din

//----------------------------------------------------------------------

module Sign_Extend #(

//-----------------------------------------------------------------------
//                    Parameters Decleration   
//-----------------------------------------------------------------------

 parameter INSTR_WIDTH   = 16,
 parameter SIGNIMM_DEPTH = 32

)





( 
//-----------------------------------------------------------------------
//                        Port Decleration   
//-----------------------------------------------------------------------
  
  input wire [INSTR_WIDTH-1:0]      Instr,
  
  output reg [SIGNIMM_DEPTH-1:0]    SignImm
  
  );
  
  always@(*)
  
  begin
    
    if(Instr[INSTR_WIDTH-1])
      
      SignImm = {16'b1111_1111_1111_1111 ,Instr};
      
    else
    
      SignImm = {16'b0000_0000_0000_0000 ,Instr};
    
  end
  
  
endmodule