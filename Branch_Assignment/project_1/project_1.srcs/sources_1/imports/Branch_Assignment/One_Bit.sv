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

`define TABLE_DEPTH 1024
// Do not modify the ports list for the module. 

module One_Bit( input [31:0] B_Add,     // Address for indexing into the table
                input outcome,          // Boolean value for if the was branch was actually taken or not
                input clk,              // Used for updating the statemachine
                input reset,            // resets all values in the branch history table to 0
                output reg miss         // Boolean value for if the prediction was correct or not
    );

    logic BHT [0:`TABLE_DEPTH-1];		// Create a BHT memory block that is 1024 entries and 1-bit wide
    logic [9:0] BHT_address;            // Stores the address for the table entry look up
    logic predicted_outcome;            // Stores the predicted outcome before the comparison is made
    
    assign BHT_address = B_Add[11:2];   // Assign bits from PC to the Branch History table, 4-byte addressable
        
    // Update the Table
    always @ (posedge clk or posedge reset)
    begin
        if (reset == 1'b1)  begin       // Reset all of the bits in the BHT to 0
        
            for( int i = 0; i < `TABLE_DEPTH; i++)  begin
                BHT[i] = 0;
            end
        end
        else begin
        
            predicted_outcome = BHT[BHT_address];  // Retrieve the predicted (previous) state from the BHT table

            // Compare the current outcome with the actual outcome and update the table
            if (predicted_outcome != outcome) begin
                BHT[BHT_address] = outcome;
            end
        end
    end
    
    // Output Logic
    assign miss = (predicted_outcome != outcome); // If predicted_outcome is the same at the actual outcome, return a 1

    
endmodule 
  
