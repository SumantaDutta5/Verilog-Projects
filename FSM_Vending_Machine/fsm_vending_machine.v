`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sumanta Kumar Dutta
// 
// Create Date: 29.01.2025 23:21:44
// Design Name: FSM Vending Machine
// Module Name: fsm_vending_machine
// Project Name: fsm_vending_machine
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


module fsm_vending_machine(
    input clk,
    input rst,
    input [1:0] coin,           //01: Rs.5, 10: Rs.10
    output reg out,             //Cost of product: Rs. 15
    output reg change           //If balance remaining:- 0:No, 1:Yes
);

parameter S0=2'b00, S1=2'b01, S2=2'b10;     //S0: Rs.0, S1: Rs.5, S2: Rs.10 in the machine
reg[1:0] c_state, n_state;

always @(posedge clk) begin
    if(rst == 1) begin
        c_state = 0;
        n_state = 0;
        change = 1'b0;
    end
    
    else
        c_state = n_state;
        
    case(c_state)
        S0:                                 //Rs.0 in the vending machine
            if(coin == 2'b00) begin         //Adding nothing to the machine
                n_state = S0;               //Retains its current state
                out = 0;
                change = 1'b0;
            end
                
            else if(coin == 2'b01) begin    //Adding Rs.5 to the machine
                n_state = S1;               //Changes to the corresponding state
                out = 0;
                change = 1'b0;
            end
                
            else if(coin == 2'b10) begin    //Adding Rs.10 to the machine
                n_state = S2;               //Changes to the corresponding state
                out = 0;
                change = 1'b0;
            end
            
            
        S1:                                 //Rs.5 in the vending machine
            if(coin == 0) begin             //Adding nothing to the machine
                n_state = S0;               //Reverts back to the initial state
                out = 0;
                change = 1'b0;
            end
                
            else if(coin == 2'b01) begin    //Adding Rs.5 to the machine ==> Rs.10 in the machine now
                n_state = S2;               //Changes to the corresponding state
                out = 0;
                change = 1'b0;
            end
                
            else if(coin == 2'b10) begin    //Adding Rs.10 to the machine ==> Rs.15 in the machine now
                n_state = S0;               //Reverts back to the initial state
                out = 1;                    //1 unit of the product is obtained
                change = 1'b0;
            end
            
            
        S2:                                 //Rs.10 in the vending machine
            if(coin == 2'b00) begin         //Adding nothing to the machine
                n_state = S0;               //Reverts back to the initial state
                out = 0;
                change = 1'b0;
            end
                
            else if(coin == 2'b01) begin    //Adding Rs.5 to the machine ==> Rs.15 in the machine now
                n_state = S0;               //Reverts back to the initial state
                out = 1;                    //1 unit of the product is obtained
                change = 1'b0;
            end
                
            else if(coin == 2'b10) begin    //Adding Rs.10 to the machine ==> Rs.20 in the machine now
                n_state = S0;               //Reverts back to the initial state
                out = 1;                    //1 unit of the product is obtained
                change = 1'b1;              //Balance amount of Rs.5 is left
            end
            
    endcase
end
endmodule
