//-----------------------------------------------------------------------

// Module: Adder

// File Name: Adder.V

// Description: adder block that adds two 32-bit data inputs to each other (A and B) and produces the output to the 32-bit port C 

// Author: Omar Hossam El Din

//----------------------------------------------------------------------

module Adder #(

//-----------------------------------------------------------------------
//                    Parameters Decleration   
//-----------------------------------------------------------------------


 parameter DATA_WIDTH   = 32

)





( 
//-----------------------------------------------------------------------
//                        Port Decleration   
//-----------------------------------------------------------------------
  
  input wire  [DATA_WIDTH-1:0]      A,
  
  input wire  [DATA_WIDTH-1:0]      B,
  
  output reg [DATA_WIDTH-1:0]      C
  
  );
  
 always @(*)
 begin
   
   C = A + B;
   
 end
  
endmodule



