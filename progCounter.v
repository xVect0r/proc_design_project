module progCounterRegWrite(
    input [31:0] instAddress_req;
    input controlPC,
    output reg [31:0] instAddress_read;
);

//start_at_first_inst
initial begin
    $display("Program starts execution")
   instAddress_read=32'b0; 
end
//move_to_given_instruction
always @(instAddress_req) begin
    $display("Program progresses at signal from Control")
    if(cntrolPC==1'b1) out=in;
end

endmodule