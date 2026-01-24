`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sumanta Kumar Dutta
// 
// Create Date: 24.01.2026 16:40:48
// Design Name: Synchronous FIFO Testbench
// Module Name: tb_fifo_sync
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


module tb_fifo_sync();
    //Specifying the testbench variables
    //Inputs:-
    parameter FIFO_DEPTH = 8;
    parameter DATA_WIDTH = 32;
    reg clk = 0;
    reg rst_n, cs, wr_en, rd_en;
    reg [DATA_WIDTH-1:0] data_in;
    
    //Outputs:-
    wire [DATA_WIDTH-1:0] data_out;
    wire empty, full;
    
    integer i;
    
    //Instantiating the FIFO, i.e. creating a DUT
    fifo_sync #(.FIFO_DEPTH(FIFO_DEPTH),.DATA_WIDTH(DATA_WIDTH)) dut(.clk(clk),.rst_n(rst_n),.cs(cs),.wr_en(wr_en),.rd_en(rd_en),.data_in(data_in),.data_out(data_out),.empty(empty),.full(full));
    
    //Clock Generation
    always begin #5 clk = ~clk; end
    
    //write operation using the concept of task
    task write_data(input [DATA_WIDTH-1:0] d_in); begin
        @(posedge clk); // sync to positive edge of clock
            cs = 1; wr_en = 1;
        data_in = d_in;
        $display($time, " write_data data_in = %0d", data_in);
        @(posedge clk);
            cs = 1; wr_en = 0;
        end
    endtask
    
    //read operation using the concept of task
    task read_data(); begin
        @(posedge clk);  // sync to positive edge of clock
            cs = 1; rd_en = 1;
        @(posedge clk);
            //#1;
            $display($time, " read_data data_out = %0d", data_out);
        cs = 1; rd_en = 0;
        end
    endtask
    
    
    //Creating stimulus
    initial begin
        #1;
        rst_n = 0; rd_en = 0; wr_en = 0;

        @(posedge clk)
            rst_n = 1;
            $display($time, "\n Test-1:-");
            write_data(1);
            write_data(10);
            write_data(100);
            read_data();
            read_data();
            read_data();
            //read_data();

            $display($time, "\n Test-2:-");
            for (i=0; i<FIFO_DEPTH; i=i+1) begin
                write_data(2**i);
                read_data();
            end

            $display($time, "\n Test-3:-");
            for (i=0; i<=FIFO_DEPTH; i=i+1) begin
                write_data(2**i);
            end

            for (i=0; i<FIFO_DEPTH; i=i+1) begin
                read_data();
            end

            #40 $finish;
    end

    initial begin
	$dumpfile("fifo_dump.vcd"); $dumpvars;
    end
endmodule
