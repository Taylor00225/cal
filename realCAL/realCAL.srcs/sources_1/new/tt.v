`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/17 21:25:47
// Design Name: 
// Module Name: tt
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


module tt(
    input clkin,
    output clkout_100k
    );

    reg clkout_100k;
    integer cnt;
 
    always @ (posedge clkin) 
    begin
       if(cnt==499)
           begin clkout_100k<=(~clkout_100k);
           cnt<=0;
           end
       else
         begin
            cnt<=cnt+1;
            end
    end


endmodule
