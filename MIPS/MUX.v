//-----------------------------------------------------------------------

// Module: MUX

// File Name: MUX.V

// Description: 2X1 MUX.

// Author: Omar Hossam El Din

//----------------------------------------------------------------------

module MUX #(

//-----------------------------------------------------------------------
//                    Parameters Decleration   
//-----------------------------------------------------------------------

 parameter DATA_WIDTH   = 32


)





( 
//-----------------------------------------------------------------------
//                        Port Decleration   
//-----------------------------------------------------------------------
  
  input wire  [DATA_WIDTH-1:0]      IN1,
  
  input wire  [DATA_WIDTH-1:0]      IN2,
  
  input wire                        Sel,
  
  output reg  [DATA_WIDTH-1:0]      OUT
  
  );
  
  always@(*)
  
  begin
    
  if(Sel)
    
    OUT = IN2;
    
  else
    
    OUT = IN1;
    
  end
  
  
endmodule





