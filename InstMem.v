module InstMem(
    input instRead,
    input [31:0] instAddress,
    output reg [31:0] InstRead
);

//memory_arry_instantiation
reg [31:0] instArray [255:0];
reg [31:0] word_indx;

//loop_to_initialize_mem_to_0
integer loop_var;
initial begin
    for (loop_var=0;loop_var<255;loop_var=loop_var+1) begin
        instArray[loop_var] = 32'b0;
    end
end
//when instruction is recieved read the instruction file and fetch the 
always @(instRead, instAddress ) begin
    if(instRead) begin
        word_indx = instAddress>>2;
        instRead=instArray[word_indx];
    end
end

endmodule