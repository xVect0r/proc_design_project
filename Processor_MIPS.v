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

controlUnit u1(clk,instrWireIDhazard[31:26],instrWireIDhazard[5:0],ALUOp,RegDest,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,Branch,Jump,instrWireIDhazard);/*ID*/

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
mux2 u12(ALUSrcEX,readData2EX,outSignEXTEX,ALUSrc1);/*EX*/

wire [3:0]ALUCtrl;
ALUcontrol u13(clk,instrWireID[5:0],ALUOp,ALUCtrl);/*ID*/

wire [31:0]ALUResult;
wire ZeroOut;
wire greaterThan;
wire lesserThan;
ALU_Module u14(readData1EX,ALUSrc1,ALUCtrlEX,ALUResult,ZeroOut, greaterThan, lesserThan);/*EX*/

wire [31:0]outputData;
Memory u15(MemReadMEM, MemWriteMEM,ALUResultMEM , readData2MEM, outputData);/*MEM*/

mux2 u16(MemToRegWB,ALUResultWB,outputDataWB,WBData);/*WB*/
////////////////////////////////////////////////////////////
wire [31:0]outputSLL;
leftShift2bit u3(outSignEXTEX,outputSLL);/*EX*/

wire [31:0]nextPCBranch;
addr32bit u5(nextPCEX,outputSLL,nextPCBranch);/*EX*/

wire branchEnable;
assign branchEnable= ZeroOutMEM & BranchMEM;/*MEM*/

wire [31:0]NPC0;
mux2 u6(branchEnable,nextPCMEM,nextPCBranchMEM,NPC0);/*MEM*/

wire [27:0]nextPCJump;
jumpShift u7(instrWireID[25:0],nextPCJump);/*ID*/

wire [31:0]NPC1;
JumpAddressGeneration u20(nextPC[31:28],nextPCJump,NPC1);/*ID*/

wire [31:0]NPCValue;
mux2 u8(JumpMEM,NPC0,NPC1MEM,NPCValue);/*MEM*/

progCounterRegWrite u9(NPCValue,PC,dataStall);/*MEM*/

////////////////////////////////////////////////////////////
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