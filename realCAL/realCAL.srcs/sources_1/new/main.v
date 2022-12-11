`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/08 20:34:30
// Design Name: 
// Module Name: main
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


module main(
    input clkin,
    input [3:0] key_in,
    output [3:0] key_out,
//    output key_en,
    output [6:0] seg7,
    output [1:0]seg_en,
    output [7:0] led
    );

    wire clk_100k,key_en;
    wire[7:0] key_value;
    reg clk_new = 1'b0;
    reg [6:0] seg7;
    reg [3:0] num;
    reg [1:0]seg_en;
    integer cnt;
    integer flag = 0;
    integer flag1 = 1;
    integer flag2 = 0;
    reg [7:0] num1 = 8'b00000000;
    reg [7:0] num2 = 8'b00000000;
    reg [7:0] num3 = 8'b00000000;
    reg [7:0] outputnum = 0;
    reg [7:0] led = 8'b00000000;
    integer sign = 0;//0 = +
    
    always @ (posedge clkin)
    begin 
        if(cnt == 499999)
            begin clk_new<=(~clk_new);
            cnt<=0;
            end
        else 
            begin
                cnt<=cnt+1;
            end
    end

    tt U1(clkin, clk_100k);
    keyboard U3(clk_100k,key_in,key_en,key_out,key_value);
    
     always@(negedge clkin)
       begin
       if(key_en)
       begin
           case(key_value)         
                    8'b0111_0111:num<=4'b0001; //1
                    8'b0111_1011:num<=4'b0010;
                    8'b0111_1101:num<=4'b0011;
                    8'b1011_0111:num<=4'b0100;
                    8'b1011_1011:num<=4'b0101;
                    8'b1011_1101:num<=4'b0110; //6
                    8'b1101_0111:num<=4'b0111;
                    8'b1101_1011:num<=4'b1000; //8
                    8'b1101_1101:num<=4'b1001;
                    8'b1110_1011:num<=4'b0000; //0
                    8'b0111_1110:num<=4'b1110; //+
                    8'b1011_1110:num<=4'b1101; //-
                    8'b1101_1110:num<=4'b1100; //=
                    default : num<=4'b1111;	
                    endcase
	   end
            case(num)
                4'b1110:begin sign <= 0;flag1 <= 2;end//input sign +
                4'b1101:begin sign <= 1;flag1 <= 2;end//input sign - 
                4'b1100:begin sign <= 2;flag1 <= 3;end
                4'b1111:begin sign <= sign;flag1 <= flag1;end
                default : 
                    begin
                        if (flag1 == 1)
                        begin
                            num1[3:0] <= num;
                            num3 <= 8'b00000000;
                        end
                        if (flag1 == 2)
                        begin
                            num2[3:0] <= num;
                        end
                        if (flag1 == 3)
                        begin
                            flag1 <= 1;
                        end
                    end
            endcase
        
            if(sign == 0)
                begin
                    num3 = num1 + num2;
                    if (num3 > 4'b1001)
                    begin
                        num3 <= num3 + 6;
                    end
                end
            if(sign == 1)
                begin
                    num3 = num1 - num2;
                end
        
            if (flag1 == 1)
            begin
                outputnum = num1;
            end
            if (flag1 == 2)
            begin
                outputnum = num2;
            end
            if (flag1 == 3)
            begin
                outputnum = num3;
            end
            led = outputnum;
        end
        
    always @(posedge clk_new)
    begin
        if (flag == 0)
        begin
            seg_en <=2'b10;
            flag <= 1;
            case(outputnum[7:4])
                4'b0000: seg7<=7'b0111111;
                4'b0001: seg7<=7'b0000110;
                4'b0010: seg7<=7'b1011011;
                4'b0011: seg7<=7'b1001111;
                4'b0100: seg7<=7'b1100110;
                4'b0101: seg7<=7'b1101101;
                4'b0110: seg7<=7'b1111101;
                4'b0111: seg7<=7'b0000111;
                4'b1000: seg7<=7'b1111111;
                4'b1001: seg7<=7'b1101111;
                default: seg7<=7'b0000000;
            endcase
        end
        if (flag == 1)
        begin
            seg_en <=2'b01;
            flag <= 0;
            case(outputnum[3:0])
                4'b0000: seg7<=7'b0111111;
                4'b0001: seg7<=7'b0000110;
                4'b0010: seg7<=7'b1011011;
                4'b0011: seg7<=7'b1001111;
                4'b0100: seg7<=7'b1100110;
                4'b0101: seg7<=7'b1101101;
                4'b0110: seg7<=7'b1111101;
                4'b0111: seg7<=7'b0000111;
                4'b1000: seg7<=7'b1111111;
                4'b1001: seg7<=7'b1101111;
                default: seg7<=7'b0000000;
            endcase
        end        

        
        

    end 
endmodule 