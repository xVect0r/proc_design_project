module ALU_Module(
    input [31:0] data_in1,
    input [31:0] datat_in2,
    input [3:0] ALUOpCode,
    output reg [31:0] resultOut,
    output reg zeroFlag,
    output reg lessThanFlag,
    output greaterThanFlag
);

always @(ALUOpCode, data_in2, data_in2) begin
    case (ALUOpCode)
    // we can add more opcodes here to create more functionality in the ALU.
    4'b0000: resultOut = data_in1+data_in2;
    4'b0001: resultOut = data_in1-data_in2;
    4'b0010: resultOut = data_in1&data_in2;
    4'b0011: resultOut = data_in1|data_in2;

    default: resultOut = data_in1+data_in2;
    endcase

    if(data_in1>data_in2) begin
        $display("Greater than true")
        greaterThanFlag = 1'b1;
        lessThanFlag = 1'b0;

    end

    else if (data_in1< data_in2) begin
        $display("Lesser than true")
        greaterThanFlag = 1'b0;
        lessThanFlag =1'b1;
    end

    else begin
        $display("Both are equal")
        greaterThanFlag = 1'b0;
        lessThanFlag = 1'b0;
    end

    if (resultOut == 32'd0) begin 
        zeroFlag=1'b1;
        $display("Jump initiated")
    end
    else zeroFlag = 1'b0;


end

endmodule