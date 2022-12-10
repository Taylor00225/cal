`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/8 08:16:45
// Design Name: 
// Module Name: bounce_time
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


module bounce_time(
    input clk,
    input start,
    output done

    );
    reg done = 1'b0;
    integer cnt;
    always @ (posedge clk) 
    begin
        if(start)
        begin
            if(cnt==2000)//20ms
            begin
                done<=1'b1;
            end
            else
            begin
                cnt<=cnt+1;
            end
        end         
        else
        begin
            done <= 1'b0;
        cnt <= 0;
        end          
    end
endmodule
