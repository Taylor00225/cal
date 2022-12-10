`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/08 08:11:39
// Design Name: 
// Module Name: keyborad
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


module keyboard(
    input clkin,
    input [3:0] key_in,
    output key_en,
    output [3:0] key_out,
    output[7:0] key_value
    );
    
    reg[3:0] key_out=4'b1111;
    reg start,key_en;
    wire done;
    reg[7:0] key_value;
    integer flag=0;
    
    bounce_time U2(clkin,start,done);
    always@(posedge clkin)
    begin
        if(flag==0)
              begin
	                start <= 1'b0;
	                key_en<=1'b0;
					key_out<=4'b1110;//lie 
					key_value[3:0] <= 4'b1110;           
                    flag<= flag+1;
               end
          
         else if(flag==1)
               begin
					if(key_in != 4'b1111)
					 begin
						if(!done)
                             begin
                                start <= 1'b1;
                             end
						else
                             begin
                                start <= 1'b0;
                             end
						
						if(start && done)
                             begin
                                key_value[7:4] <= key_in;
                                key_en<= 1'b1;
                                flag<=flag+1;
                             end						
					   end
					else
					 begin
						start <= 1'b0;
					key_en<= 1'b0;
						flag=flag+1;
					 end					 
				 end
				 
         else if(flag==2)
              begin
                        start <= 1'b0;
                      key_en<=1'b0;
                         key_out<=4'b1101;//lie
                        key_value[3:0] <= 4'b1101;           
                        flag=3;
              end
              
          else if(flag==3)    
                begin
					if(key_in != 4'b1111)
					 begin
						if(!done)
                             begin
                                start <= 1'b1;
                             end
						else
                             begin
                                start <= 1'b0;
                             end
						
						if(start && done)
                             begin
                                key_value[7:4] <= key_in;
                            key_en<= 1'b1;
                                flag=4;
                             end						
					   end
					else
					 begin
						start <= 1'b0;
					key_en<= 1'b0;
						flag=4;
					 end					 
				 end
				 
		    else if(flag==4)   
		        begin
                        start <= 1'b0;
                    key_en<=1'b0;
                         key_out<=4'b1011;//lie
                        key_value[3:0] <= 4'b1011;           
                        flag=5;
                end 
                
            else if(flag==5)    
                begin
					if(key_in != 4'b1111)
					 begin
						if(!done)
                             begin
                                start <= 1'b1;
                             end
						else
                             begin
                                start <= 1'b0;
                             end
						
						if(start && done)
                             begin
                                key_value[7:4] <= key_in;
                              key_en<= 1'b1;
                                flag=6;
                             end						
					   end
					else
					 begin
						start <= 1'b0;
					key_en<= 1'b0;
						flag=6;
					 end					 
				 end
				 
		 else if(flag==6)   
		        begin
                        start <= 1'b0;
                     key_en<=1'b0;
                         key_out<=4'b0111;//lie
                        key_value[3:0] <= 4'b0111;           
                        flag=7;
                end 
                
           else if(flag==7)    
                begin
					if(key_in != 4'b1111)
					 begin
						if(!done)
                             begin
                                start <= 1'b1;
                             end
						else
                             begin
                                start <= 1'b0;
                             end
						
						if(start && done)
                             begin
                                key_value[7:4] <= key_in;
                            key_en<= 1'b1;
                                flag=0;
                             end						
					   end
					else
					 begin
						start <= 1'b0;
						key_en<= 1'b0;
						flag=0;
					 end					 
				 end
				 
      end
endmodule
