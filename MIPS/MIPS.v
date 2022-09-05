//-----------------------------------------------------------------------

// Module: MIPS

// File Name: DataPath.V

// Description: 

// Author: Omar Hossam El Din

//----------------------------------------------------------------------

module MIPS #(
  
//-----------------------------------------------------------------------
//                    Parameters Decleration   
//-----------------------------------------------------------------------
parameter DATA_WIDTH  = 32,
parameter ADDRESS_WIDTH  = 5,
parameter INSTR_WIDTH = 32,
parameter PC_WIDTH    = 32 

)
  
  (
//-----------------------------------------------------------------------
//                        Port Decleration   
//-----------------------------------------------------------------------
input  wire                                   CLK,
input  wire                                   RST, 
output wire   [15:0]                          test_value
  );
  
  
//-----------------------------------------------------------------------
//                        Internal Connections   
//-----------------------------------------------------------------------
wire [DATA_WIDTH-1:0]    ReadData;

wire [DATA_WIDTH-1:0]    WriteData;
wire [PC_WIDTH-1:0]      PC;
wire [INSTR_WIDTH-1:0]   Instr;
wire [ADDRESS_WIDTH-1:0] WriteReg;
wire [DATA_WIDTH-1:0]    Result;
wire [DATA_WIDTH-1:0]    SrcA;
wire [DATA_WIDTH-1:0]    SrcB;
wire [DATA_WIDTH-1:0]    SignImm;
wire [DATA_WIDTH-1:0]    ALUResult; 
wire                     ZERO;
wire [DATA_WIDTH-1:0]    OUT_SHIFT_LEFT1;          
wire [27:0]              OUT_SHIFT_LEFT2;
wire [PC_WIDTH-1:0]      PCPlus4;
wire [PC_WIDTH-1:0]      PCBranch;
wire                     PCSrc;
wire [PC_WIDTH-1:0]      OUT_MUX2;
wire [PC_WIDTH-1:0]      PC_IN;
wire                     MemWrite;
wire                     MemtoReg;
wire                     Branch;
wire                     Jump;
wire                     RegWrite;
wire                     RegDst;
wire                     ALUSrc;
wire [2:0]               ALUControl;




assign PCSrc = Branch & ZERO;

//-----------------------------------------------------------------------
//                           Port Mapping  
//----------------------------------------------------------------------- 

Control_Unit U0_Control_Unit(
.Funct(Instr[5:0]),
.Opcode(Instr[31:26]),
.memtoReg(MemtoReg),
.memWrite(MemWrite),
.Branch(Branch),
.ALUSrc(ALUSrc),
.RegDest(RegDst),
.RegWrite(RegWrite),
.Jump(Jump),
.ALUControl(ALUControl)
);

Register_File #( .ADDRESS_WIDTH(ADDRESS_WIDTH), .REGISTER_WIDTH(DATA_WIDTH), .REGISTER_DEPTH(100)) U0_Register_File (
.A1(Instr[25:21]),
.A2(Instr[20:16]),
.A3(WriteReg),
.WD3(Result),
.WE3(RegWrite),
.CLK(CLK),
.RST(RST),
.RD1(SrcA),
.RD2(WriteData)
);

MUX #(.DATA_WIDTH(ADDRESS_WIDTH)) U0_MUX(
.IN1(Instr[20:16]),
.IN2(Instr[15:11]),
.Sel(RegDst),
.OUT(WriteReg)
);

Sign_Extend #(.INSTR_WIDTH(16), .SIGNIMM_DEPTH(32))  U0_Sign_Extend(

.Instr(Instr[15:0]),
.SignImm(SignImm)
);

shift_left_twice #(.IN_WIDTH(DATA_WIDTH), .OUT_WIDTH(DATA_WIDTH)) U0_shift_left_twice(
.IN(SignImm),
.OUT(OUT_SHIFT_LEFT1)
);

Adder #(.DATA_WIDTH(DATA_WIDTH)) U0_Adder(

.A(OUT_SHIFT_LEFT1),
.B(PCPlus4),
.C(PCBranch)

);

MUX #(.DATA_WIDTH(DATA_WIDTH)) U1_MUX(
.IN1(WriteData),
.IN2(SignImm),
.Sel(ALUSrc),
.OUT(SrcB)
);

ALU #(.DATA_WIDTH(DATA_WIDTH), .ALUControl_WIDTH(3))   U0_ALU(

.SrcA(SrcA),
.SrcB(SrcB),
.ALU_Control(ALUControl),
.ALU_OUT(ALUResult),
.ZERO_Flag(ZERO)
);



shift_left_twice #(.IN_WIDTH(26), .OUT_WIDTH(28)) U1_shift_left_twice(
.IN(Instr[25:0]),
.OUT(OUT_SHIFT_LEFT2)
);



MUX #(.DATA_WIDTH(DATA_WIDTH)) U2_MUX(
.IN1(PCPlus4),
.IN2(PCBranch),
.Sel(PCSrc),
.OUT(OUT_MUX2)
);

MUX #(.DATA_WIDTH(DATA_WIDTH)) U3_MUX(
.IN1(OUT_MUX2),
.IN2({PCPlus4[31:28],OUT_SHIFT_LEFT2}),
.Sel(Jump),
.OUT(PC_IN)
);

Program_Counter #(.PC_WIDTH(PC_WIDTH))   U0_Program_Counter(

.PC_IN(PC_IN),
.RST(RST),
.CLK(CLK),
.PC_OUT(PC)
);

Instruction_memory #(.MEMORY_WIDTH(DATA_WIDTH), .MEMORY_DEPTH(100), .PC_WIDTH(PC_WIDTH), .INSTR_WIDTH(INSTR_WIDTH)) U0_Instruction_memory(

.PC(PC),
.INSTR(Instr)

);


Adder #(.DATA_WIDTH(PC_WIDTH)) U1_Adder(
.A(PC),
.B(32'd4),
.C(PCPlus4)
);

Data_memory #(.MEMORY_WIDTH(DATA_WIDTH), .MEMORY_DEPTH(100), .TEST_WIDTH(16)) U0_Data_memory(
.A(ALUResult),
.WD(WriteData),
.CLK(CLK),
.WE(MemWrite),
.RST(RST),
.RD(ReadData),
.test_value(test_value)

);

MUX #(.DATA_WIDTH(DATA_WIDTH)) U4_MUX(
.IN1(ALUResult),
.IN2(ReadData),
.Sel(MemtoReg),
.OUT(Result)
);


endmodule