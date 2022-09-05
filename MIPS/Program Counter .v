//-----------------------------------------------------------------------

// Module: Program Counter

// File Name: Program Counter.V

// Description: updating the pc with every clk

// Author: Omar Hossam El Din

//----------------------------------------------------------------------


module Program_Counter #(
  
//-----------------------------------------------------------------------
//                    Parameters Decleration   
//-----------------------------------------------------------------------

parameter PC_WIDTH = 32              //initialize a parameter variable with value 32

)

(
//-----------------------------------------------------------------------
//                        Port Decleration   
//-----------------------------------------------------------------------

input  wire  [PC_WIDTH-1:0]  PC_IN,
input  wire                  RST,
input  wire                  CLK,
output reg   [PC_WIDTH-1:0]  PC_OUT
);
  
  
  always@(posedge CLK or negedge RST)
  
  begin 
    if(!RST)
      
     PC_OUT <= 'b0 ;
     
   else 
     
     PC_OUT <= PC_IN ;
     
    end
  
  
endmodule