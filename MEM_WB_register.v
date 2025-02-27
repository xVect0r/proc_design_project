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
    output reg MemToRegOutput,    // Added this
    output reg BranchsFlagOutput, // Fixed conflict
    output reg JumpsFlagOutput,   // Fixed conflict
    output reg [3:0] ALUControlOutput,  // Fixed conflict
    output reg [31:0] IROutput,   // Fixed conflict
    output reg [31:0] BOutput,
    output reg [31:0] ResultOutput,
    output reg [4:0] regDestAddressOutput,
    input controlSignal

);



initial begin
    IROutput<=32'b0;
end

always @(posedge clk) begin
    if (controlSignal) begin
        regDestsFlagOutput<=regDestsFlagInput;
        regWriteFlagOutput<=regWriteFlagInput;
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