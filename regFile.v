module regFile(
    input clk,
    input regWriteControl,
    input [4:0] readRegAddress1,
    input [4:0] readRegAddress2,
    input [4:0] writeRegAddress,
    input [31:0] writeRegData,
    output reg [31:0] readData1,
    output reg [31:0] readData2
);

//creating_the_reg_file
reg [31:0] regFile_array [31:0];

//initalizing_the_register_array
integer loop_var;
initial begin
    $display("Assigning 0 to all registers in register file");
    for (loop_var =0 ;loop_var<31 ;loop_var=loop_var+1 ) begin
        regFile_array[loop_var] = 0;
    end
end

//for_Writing_back_to_register
always @(posedge clk) begin
    $display("Writing back to the register the value %b at %b", writeRegData, writeRegAddress);
    if(regWriteControl == 1'b1) regFile_array[writeRegAddress] <= writeRegData;
    regFile_array[0] = 0;
    //hardwiring_the_values_in_register1_and2_for_faster_processing
    $display("Read_data for reg 1 and reg 2 available");
    readData1 = regFile_array[readRegAddress1];
    readData2 = regFile_array[readRegAddress2];
end



endmodule