//-----------------------------------------------------------------------

// Module: Instruction memory

// File Name: Instruction memory.V

// Description: holds the program that your CPU will execute

// Author: Omar Hossam El Din

//----------------------------------------------------------------------


module Instruction_memory #(
  
//-----------------------------------------------------------------------
//                    Parameters Decleration   
//-----------------------------------------------------------------------

parameter MEMORY_WIDTH = 32             ,  //initialize a parameter variable with value 32
parameter MEMORY_DEPTH = 100            ,  //initialize a parameter variable with value 100
parameter PC_WIDTH = 32                 ,  //initialize a parameter variable with value 32
parameter INSTR_WIDTH = 32                 //initialize a parameter variable with value 32
)
  
  (
  
//-----------------------------------------------------------------------
//                        Port Decleration   
//-----------------------------------------------------------------------
  
  input wire   [PC_WIDTH-1:0]     PC,
  output reg  [INSTR_WIDTH-1:0]   INSTR
  
  );
  
  //                  2D ARRAY

reg [MEMORY_WIDTH-1:0] instruction_memory [0:MEMORY_DEPTH-1];

initial begin
  
    $readmemh("Program 2_Factorial_of_Number.txt",instruction_memory); //reading file that contains the program.
    
end

//-----------------------------------------------------------------------
//                    Always Combinational Block   
//-----------------------------------------------------------------------

always@(*)

begin 
  
 INSTR  = instruction_memory[PC>>32'd2];
  
end
  
endmodule