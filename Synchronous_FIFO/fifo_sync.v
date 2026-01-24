`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sumanta Kumar Dutta
// 
// Create Date: 23.01.2026 21:22:58
// Design Name: Synchronous FIFO
// Module Name: fifo_sync
// Project Name: fifo_sync
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


module fifo_sync    //Parameterized synchronous FIFO design
    //Setting the constant parameters
    #(parameter FIFO_DEPTH = 8, //we have 8 locations in the FIFO
    parameter DATA_WIDTH = 32)  //each and every location of FIFO can store 32-bit of data
    //Specifying the inputs and outputs
    (input clk,
    input rst_n,    //active low reset signal
    input cs,  // chip select
    input wr_en,
    input rd_en,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output empty,
    output full);
    
    localparam FIFO_DEPTH_LOG = $clog2(FIFO_DEPTH); //FIFO_DEPTH_LOG = 3, i.e 3 bits required to address 8 FIFO locations from 000 to 111
    
    //Creating the main FIFO array
    reg [DATA_WIDTH-1:0] fifo [0:FIFO_DEPTH-1]; //8 locations (0-7) of 32-bit (0-31) length
    
    //Creating the required pointers
    reg [FIFO_DEPTH_LOG:0] write_pointer;   //4-bit pointer
    reg [FIFO_DEPTH_LOG:0] read_pointer;    //4-bit pointer
    //3 bits shall suffice; but the extra 4th MSB helps in distinguishing between an empty FIFO and a full FIFO
    
    //write operation
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)  //if reset = 0
            write_pointer <= 0; //reset the FIFO (active low reset)
        else if(cs && wr_en && !full) begin
            fifo[write_pointer[FIFO_DEPTH_LOG-1:0]] <= data_in; //writing the input data into the FIFO
            write_pointer <= write_pointer + 1'b1;  //updating the write pointer after a write operation
        end
    end
    
    //read operation
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)  //if reset = 0
            read_pointer <= 0;  //reset the FIFO (active low reset)
        else if(cs && rd_en && !empty) begin
            data_out <= fifo[read_pointer[FIFO_DEPTH_LOG-1:0]]; ////reading the FIFO data as output
            read_pointer <= read_pointer +1'b1; //updating the read pointer after a read operation
        end
    end
    
    //Designing the empty and full condition logic
    assign empty = (read_pointer == write_pointer);
    assign full = (read_pointer == {~write_pointer[FIFO_DEPTH_LOG], write_pointer[FIFO_DEPTH_LOG-1:0]});
    
endmodule
