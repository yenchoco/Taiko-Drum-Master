module mem_addr_gen(
   input clk,
   input rst,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   input [9:0] p0,
   input [9:0] p1,
   input [9:0] p2,
   input [9:0] p3,
   input [9:0] p4,
   input [9:0] p5,
   input [9:0] c0,
   input [9:0] c1,
   input [9:0] c2,
   input [9:0] c3,
   input [9:0] c4,
   input [9:0] c5,
   output reg [16:0] pixel_addr
   );
    
   reg [9:0] position; //pic x
  
   //assign pixel_addr = ((h_cnt>>1)+320*(v_cnt>>1)+ position*320 )% 76800;  //640*480 --> 320*240 
   
   always @* begin
       if(v_cnt>10'd150&&v_cnt<10'd200) begin
           if(h_cnt<=p0&&h_cnt>=p0-10'd50) begin
               if(c0==0) pixel_addr=(((h_cnt-p0+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800;
               else pixel_addr=(((h_cnt-p0+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800+625;
           end
           else if(h_cnt<=p1&&h_cnt>=p1-10'd50) begin
               if(c1==0) pixel_addr=(((h_cnt-p1+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800;
               else pixel_addr=(((h_cnt-p1+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800+625;
           end
           else if(h_cnt<=p2&&h_cnt>=p2-10'd50) begin
               if(c2==0) pixel_addr=(((h_cnt-p2+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800;
               else pixel_addr=(((h_cnt-p2+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800+625;
           end
           else if(h_cnt<=p3&&h_cnt>=p3-10'd50) begin
               if(c3==0) pixel_addr=(((h_cnt-p3+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800;
               else pixel_addr=(((h_cnt-p3+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800+625;
           end
           else if(h_cnt<=p4&&h_cnt>=p4-10'd50) begin
              if(c4==0) pixel_addr=(((h_cnt-p4+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800;
              else pixel_addr=(((h_cnt-p4+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800+625;
           end
           else if(h_cnt<=p5&&h_cnt>=p5-10'd50) begin
              if(c5==0) pixel_addr=(((h_cnt-p5+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800;
              else pixel_addr=(((h_cnt-p5+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800+625;
           end
           //(h_cnt<=position&&h_cnt>=position-10'd50) pixel_addr=(((h_cnt-position+10'd50)>>1)+25*((v_cnt-10'd150)>>1))%625+76800;
           else pixel_addr = ((h_cnt>>1)+320*(v_cnt>>1) )% 76800;  //640*480 --> 320*240 
       end
       else pixel_addr = ((h_cnt>>1)+320*(v_cnt>>1) )% 76800;  //640*480 --> 320*240 
   end

    
endmodule
