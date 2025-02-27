module ID_EX_register(
    input clk,
    //input to the register that require an putput
    input regDestsFlagInput, 
    input regWriteFlagInput, 
    input ALUSrcInput, 
    input MemReadFlagInput, 
    input MemWriteFlagInput, 
    input MemToRegInput, 
    input BranchFlagInput, 
    input JumpFlagInput,
    input [3:0] ALUControlInput,
    input [31:0] IRInput,
    input [31:0] PCInput,
    input [31:0] ARegisterInput,
    input [31:0] BRegisterInput,
    input [4:0] regDestAddressInput,
    input [31:0] BranchInput,
    input [31:0] JumpInput,
    //corresponding outputs
    output reg regDestsFlagOutput,
    output reg regWriteFlagOutput,
    output reg ALUSrcOutput,
    output reg MemReadFlagOutput,
    output reg MemWriteFlagOutput,
    output reg MemToRegOutput,
    output reg BranchFlagOutput,
    output reg JumpFlagOutput,
    output reg [3:0] ALUControlOutput,
    output reg [31:0] IROutput,
    output reg [31:0] PCOutput,
    output reg [31:0] ARegisterOutput,
    output reg [31:0] BRegisterOutput,
    output reg [4:0] regDestAddressOutput,
    output reg [31:0] BranchOutput,
    output reg [31:0] JumpOutput,
    input controlSignal
);

initial begin
    PCOutput=32'b0;
    IROutput=32'b0;
end

always @(posedge clk) begin
    if(controlSignal == 1'b1) begin
    regDestsFlagOutput <= regDestsFlagInput;
    regWriteFlagOutput<=regWriteFlagInput;
    ALUSrcOutput<=ALUSrcInput;
    MemReadFlagOutput<=MemReadFlagInput;
    MemWriteFlagOutput<=MemWriteFlagInput;
    MemToRegOutput<=MemToRegInput;
    BranchFlagOutput<=BranchFlagInput;
    JumpFlagOutput<=JumpFlagInput;
    regDestAddressOutput<=regDestAddressInput;
    ALUControlOutput<=ALUControlInput;
    IROutput<=IRInput;
    PCOutput<=PCInput;
    ARegisterOutput<=ARegisterInput;
    BRegisterOutput<=BRegisterInput;
    BranchOutput<=BranchInput;
    JumpOutput<=JumpInput;

    end
end

endmodule