//-----------------------------------------------------------------------

// Module: Register File

// File Name: Register File.V

// Description: 

// Author: Omar Hossam El Din

//----------------------------------------------------------------------


module Register_File #(
  
//-----------------------------------------------------------------------
//                    Parameters Decleration   
//-----------------------------------------------------------------------

 parameter REGISTER_WIDTH = 32,
 parameter REGISTER_DEPTH = 100,
 parameter ADDRESS_WIDTH = 5
)

  (
//-----------------------------------------------------------------------
//                        Port Decleration   
//-----------------------------------------------------------------------
  input wire [ADDRESS_WIDTH-1:0]  A1,
  input wire [ADDRESS_WIDTH-1:0]  A2,
  input wire [ADDRESS_WIDTH-1:0]  A3,
  input wire [REGISTER_WIDTH-1:0] WD3,
  input wire                      WE3,
  input wire                      CLK,
  input wire                      RST,
  output reg [REGISTER_WIDTH-1:0] RD1,
  output reg [REGISTER_WIDTH-1:0] RD2
  );
  
  reg [REGISTER_WIDTH-1:0] memory [REGISTER_DEPTH-1:0];
  
//-----------------------------------------------------------------------
//                    Always Sequential Block   
//-----------------------------------------------------------------------
always@(posedge CLK)

  begin
    
    if(WE3)
      
    memory[A3] <= WD3;
    
  else
    
    memory[A3] <= memory[A3];
    
  end
  
//-----------------------------------------------------------------------
//                    Always Sequential Block   
//-----------------------------------------------------------------------
integer i;
always@(negedge RST)
  begin
    
    for(i =0;i<REGISTER_DEPTH;i=i+1)
    
    memory [i] <= 'd0;
    
  end
  
   
//-----------------------------------------------------------------------
//                    Always Combinational  Block   
//-----------------------------------------------------------------------
always@(*)
  begin
    
   RD1 = memory[A1];
   
   RD2 = memory[A2];
   
  end
endmodule