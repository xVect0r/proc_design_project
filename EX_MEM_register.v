module EX_MEM_register(
    input clk,

    input regDestsFlagInput,
    input regWriteFlagInput,
    input ALUSrcInput,
    input memReadFlagInput,
    input memWriteFlagInput,
    input MemToRegInput,
    input BranchsFlagInput,
    input JumpsFlagInput,
    input [3:0] ALUControlInput,
    input [31:0] IRInput,
    input [31:0] PCInput,
    input [31:0] BInput,
    input [31:0] ResultInput,
    input [4:0] regDestAddressInput,
    input [31:0] BranchAddressInput,
    input [31:0] JumpAddressInput,
    input ZeroFlagInput,
    
    output reg regDestsFlagOutput,
    output reg regWriteFlagOutput,
    output reg ALUSrcOutput,
    output reg memReadFlagOutput,
    output reg memWriteFlagOutput,
    output reg MemToRegOutput,
    output reg BranchsFlagOutput,
    output reg JumpsFlagOutput,
    output reg [3:0] ALUControlOutput,
    output reg [31:0] IROutput,
    output reg [31:0] PCOutput,
    output reg [31:0] BOutput,
    output reg [31:0] ResultOutput,
    output reg [4:0] regDestAddressOutput,
    output reg [31:0] BranchAddressOutput,
    output reg [31:0] JumpAddressOutput,
    output reg  ZeroFlagOutput,
    input controlSignal
);
module EXMEM(clock,iRegDests,iRegWrite,iALUSrc,iMemRead,iMemWrite,iMemToReg,iBranchs,iJumps,iALUCtrl,
iIR,iPC,iB,iResult,iRegDest,iBranch,iJump,iZero,
oRegDests,oRegWrite,oALUSrc,oMemRead,oMemWrite,oMemToReg,oBranchs,oJumps,oALUCtrl,
oIR,oPC,oB,oResult,oRegDest,oBranch,oJump,oZero,enable);


initial begin
    PCOutput<=32'b0;
    IROutput<=32'b0;
end

always @(posedge clk) begin
    if (controlSignal==1'b1) begin
        regDestsFlagInput<=regDestsFlagOutput;
        regWriteFlagInput<=regWriteFlagOutput;
        ALUSrcInput<=ALUSrcOutput;
        memReadFlagInput<=memReadFlagOutput;
        memWriteFlagInput<=memWriteFlagOutput;
        MemToRegInput<=MemToRegOutput;
        BranchsFlagInput<=BranchsFlagOutput;
        JumpsFlagInput<=JumpsFlagOutput;
        ALUControlInput<=ALUControlOutput;
        IRInput<=IROutput;
        PCInput<=PCOutput;
        BInput<=BInput;
        ResultInput<=ResultOutput;
        JumpAddressInput<JumpAddressOutput;
        BranchAddressInput<=BranchAddressOutput;
        regDestAddressInput<=regDestAddressOutput;
        ZeroFlagInput<=ZeroFlagOutput;
    end
    
end

endmodule
