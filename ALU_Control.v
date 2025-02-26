module ALUControl(
    input clk,
    input [5:0] ALUOperation,
    input [2:0] ALUOpcode,
    output reg[3:0] ALUOutputSignal
);

always@(ALUOperation, ALUOpcode, posedge clk) begin
    $display("deciding the control signal based on the format of the code")
    case(ALUOpcode)
    3'b000:ALUOutputSignal=4'b0000;
    3'b001: ALUOutputSignal=4'b0001;
    3'b010: case(ALUOperation)
        6'b100000:ALUOutputSignal=4'b00;
        6'b100010:ALUOutputSignal=4'b01;
        6'b100100:ALUOutputSignal=4'b10;
        6'b100101:ALUOutputSignal=4'b11;
    endcase
    3'b011: ALUOutputSignal=4'b0010;
    3'b100:ALUOutputSignal=4'b0011;
    3'b111:ALUOutputSignal=4'b0101;
    default: 
    endcase
end

endmodule