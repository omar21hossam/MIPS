//-----------------------------------------------------------------------

// Module: Data memory

// File Name: Data memory.V

// Description: 

// Author: Omar Hossam El Din

//----------------------------------------------------------------------


module Data_memory #(
  
//-----------------------------------------------------------------------
//                    Parameters Decleration   
//-----------------------------------------------------------------------

parameter MEMORY_WIDTH = 32             ,  //initialize a parameter variable with value 32
parameter MEMORY_DEPTH = 100            ,  //initialize a parameter variable with value 100
parameter TEST_WIDTH = 16         
)
  
  (
  
//-----------------------------------------------------------------------
//                        Port Decleration   
//-----------------------------------------------------------------------
  
  input wire  [MEMORY_WIDTH-1:0]    A,
  input wire  [MEMORY_WIDTH-1:0]    WD,
  input wire                        WE,
  input wire                        CLK,
  input wire                        RST,
  output reg  [MEMORY_WIDTH-1:0]    RD,
  output wire  [TEST_WIDTH-1:0]     test_value
  
  );
  
  //                  2D ARRAY

reg [MEMORY_WIDTH-1:0] DATA_memory [0:MEMORY_DEPTH-1];

assign test_value = DATA_memory[32'b0];

//-----------------------------------------------------------------------
//                    Always Combinational  Block   
//-----------------------------------------------------------------------
always@(*)
  begin
   RD = DATA_memory[A];
  
  end
  
  
  
//-----------------------------------------------------------------------
//                    Always Sequential Block   
//-----------------------------------------------------------------------
integer i;

always@(posedge CLK or negedge RST)

  begin
    if(!RST)
      
    for(i =0;i<MEMORY_DEPTH;i=i+1)
  
    DATA_memory [i] <= 32'd0;
    
  else if(WE)
      
    DATA_memory[A] <= WD;
    
    
  end
  
  
  
endmodule
