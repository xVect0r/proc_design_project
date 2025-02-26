module Memory(
    input memReadFlag,
    input memWriteFlag,
    input [31:0] MemAddress,
    input [31:0] WriteDataInput,
    output reg [31:0] ReadDataOutput
);

//creating the memory bank
reg [31:0] memoryArray [127:0];
wire [6:0] memoryAccess ;
assign memoryAccess = MemAddress[6:0]

integer loop_var;
initial begin
    $display("The memory is being flushed with null values")
    for(loop_var=0;loop_var<127;loop_var=loop_var+1) memoryArray[loop_var] = 32'b0;
end

always @(memReadFlag, memWriteFlag, MemAddress, WriteDataInput) begin
    if(memReadFlag)begin
        $display("The memory is being read")
        ReadDataOutput = memoryArray[memoryAccess];
    end

    if(memWriteFlag) begin
        $display("The memory is being written")
        memoryArray[memoryAccess] = WriteDataInput;
    end
end

endmodule