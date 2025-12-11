`timescale 1ns / 1ps

module digital_clock(
    input clk,
    input rst,
    output reg [5:0] sec,
    output reg [5:0] min,
    output reg [4:0] hr
    );
    
    always@(posedge clk, negedge rst) begin
        if(rst) begin
            sec <= 0;
            min <= 0;
            hr <= 0;
        end
        
        else begin
            if(sec==59) begin
                sec <= 0;
                if(min == 59) begin
                    min <= 0;
                    if(hr==23)
                        hr <= 0;
                    else hr <= hr + 1;
                end    
                else min <= min + 1;
            end
            else sec <= sec + 1;
        end
    end        
endmodule
