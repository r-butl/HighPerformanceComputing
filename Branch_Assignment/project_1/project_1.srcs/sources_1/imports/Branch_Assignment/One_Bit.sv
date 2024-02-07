`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2024 07:55:12 AM
// Design Name: 
// Module Name: One_Bit
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
// 
//////////////////////////////////////////////////////////////////////////////////


// Do not modify the ports list for the module. 

module One_Bit(input [31:0] B_Add, input outcome, input clk, input reset, output reg miss
// insert your code here

    );

    logic BHT [0:1023];		// Create a BHT memory block that is 1024 entries and 1-bit wide
    logic [9:0] BHT_address;	// Stores the address for the entry look up
    
    //assign BHT_address = input[11:2];

endmodule 
  
