//-----------------------------------------------------------------------

// Module: Arithmetic and Logic unit of the alu

// File Name: ALU.V

// Description: Arithmetic and Logic Operation

// Author: Omar Hossam El Din

//----------------------------------------------------------------------

module ALU #(
//-----------------------------------------------------------------------
//                    Parameters Decleration   
//-----------------------------------------------------------------------

parameter DATA_WIDTH = 32             , //initialize a parameter variable with value 32 
parameter ALUControl_WIDTH = 3         //initialize a parameter variable with value 3


)
  
  (
//-----------------------------------------------------------------------
//                        Port Decleration   
//-----------------------------------------------------------------------
input  wire [DATA_WIDTH-1:0]         SrcA,
input  wire [DATA_WIDTH-1:0]         SrcB,
input  wire [ALUControl_WIDTH-1:0]   ALU_Control,
output reg  [DATA_WIDTH-1:0]         ALU_OUT,
output reg                           ZERO_Flag
  );
  
  
//-----------------------------------------------------------------------
//                    Always Combinational Block   
//-----------------------------------------------------------------------

always@(*)
begin
  
case(ALU_Control)
  
  3'b000: ALU_OUT = SrcA & SrcB; // and function 
  
  3'b001: ALU_OUT = SrcA | SrcB; // or function
  
  3'b010: ALU_OUT = SrcA + SrcB; // addition function
  
  3'b100: ALU_OUT = SrcA - SrcB; // subtraction function
  
  3'b101: ALU_OUT = SrcA * SrcB; // multiplication function
  
  3'b110: ALU_OUT = (SrcA < SrcB) ? 'b1 :'b0; // STL
  
  default: ALU_OUT = 'b0; // not used
  
  
endcase

if(ALU_OUT == 'b0)
  ZERO_Flag = 1'b1;
else 
  ZERO_Flag = 1'b0;
  
end





endmodule