`include "addr32bit.v"
`include "ALU_Control.v"
`include "ALU_Module.v"
`include "controlUnit_MIPS.v"
`include "EX_MEM_register.v"
`include "ID_EX_register.v"
`include "IF_ID_register.v"
`include "InstMem.v"
`include "JumpAddressGeneration.v"
`include "leftShift2Bit.v"
`include "Mem_WB_register.v"
`include "Memory_MIPS.v"
`include "mux2.v"
`include "progCounter.v"
`include "regFile.v"
`include "stallControlUnit.v"
`include "stallModule.v"
`include "valueExtender.v"

module Mypip(
    input clk 
);

wire [31:0] instrWireID,nextPCID;
wire [31:0] instrWireEX,nextPCEX,readData1EX,readData2EX,NPC1EX,outSignEXTEX;
wire [4:0] writeRegWireEX;
wire [31:0] instrWireMEM,readData2MEM,ALUResultMEM,nextPCBranchMEM,NPC1MEM,nextPCMEM;
wire [4:0] writeRegWireMEM;
wire ZeroOutMEM;
wire [31:0] instrWireWB,ALUResultWB,outputDataWB;
wire [4:0] writeRegWireWB;

wire RegDestEX,RegWriteEX,ALUSrcEX,MemReadEX,MemWriteEX,MemToRegEX,BranchEX,JumpEX;
wire [3:0]ALUCtrlEX;
wire RegDestMEM,RegWriteMEM,ALUSrcMEM,MemReadMEM,MemWriteMEM,MemToRegMEM,BranchMEM,JumpMEM;
wire [3:0]ALUCtrlMEM;
wire RegDestWB,RegWriteWB,ALUSrcWB,MemReadWB,MemWriteWB,MemToRegWB,BranchWB,JumpWB;
wire [3:0]ALUCtrlWB;

wire dataStall;
wire controlStall;

wire [31:0]PC;
wire [31:0]nextPC;
wire [31:0]instrWire;
wire [2:0]ALUOp;
wire RegDest,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,Branch,Jump;
wire [31:0]instrWireIDhazard,instrWireHazard;
InstMem u0(1'b1, PC,instrWire);/*IF*/

addr32bit u4(32'b100,PC,nextPC);/*IF*/

stallUnit u90(clk, instrWireID[25:21], instrWireID[20:16],instrWireID[31:26],instrWireID,instrWireEX,instrWireMEM,writeRegWireWB,RegWriteWB,instrWireWB,dataStall);
stallControlUnit u92(clk,instrWireID[31:26],instrWireEX[31:26],instrWireMEM[31:26],controlStall);
nopSet u91(clk,dataStall,controlStall,instrWire,instrWireID,instrWireHazard,instrWireIDhazard);

controlUnit u1(clk,instrWireIDhazard[31:26],instrWireIDhazard[5:0],instrWireIDhazard,ALUOp,RegDest,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,Branch,Jump);/*ID*/

wire [4:0]writeRegWire;

mux2 u10A(RegDest,instrWireID[16],instrWireID[11],writeRegWire[0]);
mux2 u10B(RegDest,instrWireID[17],instrWireID[12],writeRegWire[1]);
mux2 u10C(RegDest,instrWireID[18],instrWireID[13],writeRegWire[2]);
mux2 u10D(RegDest,instrWireID[19],instrWireID[14],writeRegWire[3]);
mux2 u10E(RegDest,instrWireID[20],instrWireID[15],writeRegWire[4]);

wire [31:0]readData1,readData2;
wire [31:0]WBData;
regFile u11(clk, RegWriteWB, instrWireID[25:21], instrWireID[20:16],writeRegWireWB, WBData, readData1, readData2);

wire [31:0]ALUSrc1;
wire [31:0]outSignEXT;
valueExtender u2(instrWireID[15:0],outSignEXT);/*ID*/

genvar loop_var_u12;
generate
    for (loop_var_u12 = 0;loop_var_u12<32 ;loop_var_u12=loop_var_u12+1 ) begin
        mux2 u12(ALUSrcEX,readData2EX[loop_var_u12],outSignEXTEX[loop_var_u12],ALUSrc1[loop_var_u12]);/*EX*/
    end
endgenerate



wire [3:0]ALUCtrl;
ALUControl u13(instrWireID[5:0],ALUOp,ALUCtrl);/*ID*/

wire [31:0]ALUResult;
wire ZeroOut;
wire greaterThan;
wire lesserThan;
ALU_Module u14(readData1EX,ALUSrc1,ALUCtrlEX,ALUResult,ZeroOut, greaterThan, lesserThan);/*EX*/

wire [31:0]outputData;
Memory u15(MemReadMEM, MemWriteMEM,ALUResultMEM , readData2MEM, outputData);/*MEM*/

genvar loop_var_u16;
generate
    for (loop_var_u16 = 0;loop_var_u16<32 ;loop_var_u16=loop_var_u16+1 ) begin
        mux2 u16(MemToRegWB,ALUResultWB[loop_var_u16],outputDataWB[loop_var_u16],WBData[loop_var_u16]);/*WB*/     
    end
endgenerate

////////////////////////////////////////////////////////////
wire [31:0]outputSLL;
leftShift2Bit u3(outSignEXTEX,outputSLL);/*EX*/

wire [31:0]nextPCBranch;
addr32bit u5(nextPCEX,outputSLL,nextPCBranch);/*EX*/

wire branchEnable;
assign branchEnable= ZeroOutMEM & BranchMEM;/*MEM*/

wire [31:0]NPC0;
genvar loop_var_u6;
generate
    for (loop_var_u6 = 0;loop_var_u6<32 ;loop_var_u6=loop_var_u6+1 ) begin
        mux2 u6(branchEnable,nextPCMEM[loop_var_u6],nextPCBranchMEM[loop_var_u6],NPC0[loop_var_u6]);/*MEM*/
    end
endgenerate


wire [27:0]nextPCJump;
jumpShift u7(instrWireID[25:0],nextPCJump);/*ID*/

wire [31:0]NPC1;
JumpAddressGeneration u20(nextPC[31:28],nextPCJump,NPC1);/*ID*/

wire [31:0]NPCValue;

genvar loop_var_u8;
generate
    for (loop_var_u8 = 0;loop_var_u8<32 ;loop_var_u8=loop_var_u8+1 ) begin
        mux2 u8(JumpMEM,NPC0[loop_var_u8],NPC1MEM[loop_var_u8],NPCValue[loop_var_u8]);/*MEM*/
    end
endgenerate



progCounterRegWrite u9(NPCValue,dataStall,PC);/*MEM*/

IF_ID_register p1(clk,instrWireHazard,nextPC,instrWireID,nextPCID,dataStall);

ID_EX_register p2(clk,RegDest,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,Branch,Jump,ALUCtrl,
instrWireID,nextPCID,readData1,readData2,writeRegWire,outSignEXT,NPC1,
RegDestEX,RegWriteEX,ALUSrcEX,MemReadEX,MemWriteEX,MemToRegEX,BranchEX,JumpEX,ALUCtrlEX,
instrWireEX,nextPCEX,readData1EX,readData2EX,writeRegWireEX,outSignEXTEX,NPC1EX,1'b1);

EX_MEM_register p3(clk,RegDestEX,RegWriteEX,ALUSrcEX,MemReadEX,MemWriteEX,MemToRegEX,BranchEX,JumpEX,ALUCtrlEX,
instrWireEX,nextPCEX,readData2EX,ALUResult,writeRegWireEX,nextPCBranch,NPC1EX,ZeroOut,
RegDestMEM,RegWriteMEM,ALUSrcMEM,MemReadMEM,MemWriteMEM,MemToRegMEM,BranchMEM,JumpMEM,ALUCtrlMEM,
instrWireMEM,nextPCMEM,readData2MEM,ALUResultMEM,writeRegWireMEM,nextPCBranchMEM,NPC1MEM,ZeroOutMEM,1'b1);

MEM_WB_register p4(clk,RegDestMEM,RegWriteMEM,ALUSrcMEM,MemReadMEM,MemWriteMEM,MemToRegMEM,BranchMEM,JumpMEM,ALUCtrlMEM,
instrWireMEM,outputData,ALUResultMEM,writeRegWireMEM,
RegDestWB,RegWriteWB,ALUSrcWB,MemReadWB,MemWriteWB,MemToRegWB,BranchWB,JumpWB,ALUCtrlWB,
instrWireWB,outputDataWB,ALUResultWB,writeRegWireWB,1'b1);

endmodule