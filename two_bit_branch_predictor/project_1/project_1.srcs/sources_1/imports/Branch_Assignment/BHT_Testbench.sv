`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dr. Hadil Mustafa
// 
// Create Date: 02/05/2024 10:41:24 AM
// Design Name: 
// Module Name: BHT_Testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// Do not change the testbench, modify the names and the size of // the test vector only
//////////////////////////////////////////////////////////////////////////////////


module BHT_Testbench();

logic [31:0] B_Add;
logic outcome;
logic clk;
logic miss;
logic reset;

logic [31:0] onebit_misses;
logic [35:0] data_in [0:31]; // modify the size to match the test
logic [19:0] vectornum;
logic [3:0] result;

integer missrate;

// instintiate the module here. Make sure to change the name of the module to match your design. 


One_Bit UUT( B_Add, outcome, clk, reset, miss);

initial begin 
 $readmemh("/home/lucas/Desktop/programming/HighPerformanceComputing/one_bit_branch_predictor/Test2.mem",data_in); //change the file name 
    clk=0;
    B_Add=32'h00000000;
    vectornum=0;
    onebit_misses = 32'h00000000;
    reset = 1;
    result=4'b0000;
    #2 reset=0;
     
end 
assign  outcome=result[0];
always #5 clk=~clk;                             // create a free running clock

 always @(posedge clk) begin
 if (~reset) begin                            // after each posedge of the clock read one line of from the file
 {B_Add ,result} <= data_in[vectornum];

 end 
end
// check the result at falling edge of the clk

always@ (negedge clk)  begin
if (~reset) begin
onebit_misses=onebit_misses + miss;            // increment the total number of misses if applicable
vectornum=vectornum+1; 

if (data_in[vectornum]===36'hxxxxxxxxx) begin 
    missrate=((onebit_misses*100)+(vectornum-1)/2)/(vectornum-1);
    $display("end of test, number of misses = %d, miss rate = %d", onebit_misses, missrate);
    
    
    $stop;
   end 
end
end 

endmodule
