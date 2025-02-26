module MEM_WB_register(
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
    input [31:0] BInput,
    input [31:0] ResultInput,
    input [4:0] regDestAddressInput,

    output reg regDestsFlagOutput,
    output reg regWriteFlagOutput,
    output reg ALUSrcOutput,
    output reg memReadFlagOutput,
    output reg memWriteFlagOutput,
    output reg BranchsFlagInput,
    output reg JumpsFlagInput,
    output reg [3:0] ALUControlInput,
    output reg [31:0] IRInput,
    output reg [31:0] BOutput,
    output reg [31:0] ResultOutput,
    output reg [4:0] regDestAddressOutput,
    input controlSignal

);

module MEMWB(clock,iRegDests,iRegWrite,iALUSrc,iMemRead,iMemWrite,iMemToReg,iBranchs,iJumps,iALUCtrl,
iIR,iB,iResult,iRegDest,
oRegDests,oRegWrite,oALUSrc,oMemRead,oMemWrite,oMemToReg,oBranchs,oJumps,oALUCtrl,
oIR,oB,oResult,oRegDest,enable);

initial begin
    IROutput<=32'b0;
end

always @(posedge clk) begin
    if (lSignal) begin
        regDestsFlagOutput<=regDestsFlagInput;
        regWriteFlagOutput<=regWriteFlagInput
        ALUSrcOutput<=ALUSrcInput;
        memReadFlagOutput<=memReadFlagInput;
        memWriteFlagOutput<=  memWriteFlagInput;
        MemToRegOutput<=MemToRegInput;
        BranchsFlagOutput<= BranchsFlagInput;
        JumpsFlagOutput<=JumpsFlagInput;
        ALUControlOutput<=ALUControlInput;
        IROutput<=IRInput;
        BOutput<=BInput;
        ResultOutput<=ResultInput;
        regDestAddressOutput<=regDestAddressInput;
    end
end

endmodule