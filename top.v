`define silence   32'd50000000
`define c   32'd262   // C3
`define d   32'd294   // D3
`define e   32'd330   // E3
`define f   32'd349   // F3
`define g   32'd392   // G3
`define a   32'd440   // A3
`define b   32'd494   // B3
`define hc   32'd524   // C3
`define hd   32'd588   // D3
`define he   32'd660   // E3
`define hf   32'd698   // F3
`define hg   32'd784   // G3
`define ha   32'd880   // A3
`define hb   32'd988   // B3
`define lc   32'd131   // C3
`define ld   32'd147   // D3
`define le   32'd165   // E3
`define lf   32'd174   // F3
`define lg   32'd196   // G3
`define la   32'd220   // A3
`define lb   32'd247   // B3

`define sil   32'd50000000 // slience
module demo_2(
   input clk,
   input rst,
   output [3:0] vgaRed,
   output [3:0] vgaGreen,
   output [3:0] vgaBlue,
   output hsync,
   output vsync,
   input _play,
   input  _mute,
   input  _slow,
   input  _mode,
   input _music, 
   input _volUP,
   input  _volDOWN,
   input ok,
   inout PS2_DATA, 
   inout PS2_CLK, 
   output reg [15:0] _led, 
   output audio_mclk, 
   output audio_lrck, 
   output audio_sck, 
   output audio_sdin, 
   output  reg [6:0] DISPLAY, 
   output  reg [3:0] DIGIT 
    );

    wire [11:0] data;
    wire clk_25MHz;
    wire clk_22;
    wire [16:0] pixel_addr;
    wire [11:0] pixel;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480
    wire clkDiv22,clkDivjojo,clkDiv19,clkDivjo,clkk;
    wire [12:0] ibeatNum,ibeatNum2;               // Beat counter
    reg [12:0] idx2 [106:0]; //things you don't know
    reg [12:0] idx1 [92:0];  //jojo
    reg color[106:0]; //0 red 1 blue //things you don't know
    reg color1[92:0]; //jojo
    reg [10:0] i,i_next,i2,i2_next;
    reg [9:0] position [5:0][1:0]; //[0] position [1] color
    reg [5:0] good;
    initial begin
        idx2[0]=13'd96;//13'd144;   //-48
        idx2[1]=13'd112;//13'd160;
        idx2[2]=13'd128;//13'd176;
        idx2[3]=13'd160;//13'd208;
        idx2[4]=13'd168;//13'd216;
        idx2[5]=13'd224;//13'd272;
        idx2[6]=13'd232;//13'd280;
        idx2[7]=13'd240;    //288
        idx2[8]=13'd256;
        idx2[9]=13'd264;
        idx2[10]=13'd352;
        idx2[11]=13'd368;
        idx2[12]=13'd384;
        idx2[13]=13'd416;
        idx2[14]=13'd424;
        idx2[15]=13'd472;
        idx2[16]=13'd488;
        idx2[17]=13'd520;
        idx2[18]=13'd592;
        idx2[19]=13'd616;
        idx2[20]=13'd640;
        idx2[21]=13'd648;
        idx2[22]=13'd656;
        idx2[23]=13'd680;
        idx2[24]=13'd720;
        idx2[25]=13'd744;
        idx2[26]=13'd768;
        idx2[27]=13'd776;
        idx2[28]=13'd784;
        idx2[29]=13'd808;
        idx2[30]=13'd848;
        idx2[31]=13'd870;
        idx2[32]=13'd904;
        idx2[33]=13'd928;
        idx2[34]=13'd936;
        idx2[35]=13'd968;
        idx2[36]=13'd1072;
        idx2[37]=13'd1080;
        idx2[38]=13'd1088;
        idx2[39]=13'd1096;
        idx2[40]=13'd1104;
        idx2[41]=13'd1120;
        idx2[42]=13'd1128;
        idx2[43]=13'd1160;
        idx2[44]=13'd1176;
        idx2[45]=13'd1200;
        idx2[46]=13'd1208;
        idx2[47]=13'd1216;
        idx2[48]=13'd1224;
        idx2[49]=13'd1232;
        idx2[50]=13'd1248;
        idx2[51]=13'd1256;
        idx2[52]=13'd1288;
        idx2[53]=13'd1304;
        idx2[54]=13'd1328;
        idx2[55]=13'd1344;
        idx2[56]=13'd1360;
        idx2[57]=13'd1384;
        idx2[58]=13'd1400;
        idx2[59]=13'd1424;
        idx2[60]=13'd1448;
        idx2[61]=13'd1464;
        idx2[62]=13'd1488;
        idx2[63]=13'd1512;
        idx2[64]=13'd1544;
        idx2[65]=13'd1584;
        idx2[66]=13'd1592;
        idx2[67]=13'd1600;
        idx2[68]=13'd1608;
        idx2[69]=13'd1616;
        idx2[70]=13'd1632;
        idx2[71]=13'd1640;
        idx2[72]=13'd1672;
        idx2[73]=13'd1688;
        idx2[74]=13'd1712;
        idx2[75]=13'd1728;
        idx2[76]=13'd1744;
        idx2[77]=13'd1760;
        idx2[78]=13'd1768;
        idx2[79]=13'd1800;
        idx2[80]=13'd1816;
        idx2[81]=13'd1872;
        idx2[82]=13'd1888;
        idx2[83]=13'd1896;
        idx2[84]=13'd1936;
        idx2[85]=13'd1952;
        idx2[86]=13'd1960;
        idx2[87]=13'd1976;
        idx2[88]=13'd1992;
        idx2[89]=13'd2064;
        idx2[90]=13'd2120;
        idx2[91]=13'd2152;
        idx2[92]=13'd2192;
        idx2[93]=13'd2256;
        idx2[94]=13'd2344;
        idx2[95]=13'd2384;
        idx2[96]=13'd2448;
        idx2[97]=13'd2512;
        idx2[98]=13'd2536;
        idx2[99]=13'd2560;
        idx2[100]=13'd2568;
        idx2[101]=13'd2576;
        idx2[102]=13'd2600;
        idx2[103]=13'd2664;
        idx2[104]=13'd2736;
        idx2[105]=13'd2752;
        idx2[106]=13'd2768;

        color[0]=0;
        color[1]=0;
        color[2]=1;
        color[3]=0;
        color[4]=0;
        color[5]=0;
        color[6]=0;
        color[7]=0;
        color[8]=0;
        color[9]=0;
        color[10]=1;
        color[11]=1;
        color[12]=0;
        color[13]=1;
        color[14]=1;
        color[15]=1;
        color[16]=1;
        color[17]=1;
        color[18]=0;
        color[19]=0;
        color[20]=0;
        color[21]=0;
        color[22]=1;
        color[23]=0;
        color[24]=0;
        color[25]=0;
        color[26]=0;
        color[27]=0;
        color[28]=1;
        color[29]=0;
        color[30]=1;
        color[31]=1;
        color[32]=1;
        color[33]=0;
        color[34]=0;
        color[35]=1;
        color[36]=0;
        color[37]=0;
        color[38]=0;
        color[39]=0;
        color[40]=0;
        color[41]=1;
        color[42]=1;
        color[43]=0;
        color[44]=0;
        color[45]=0;
        color[46]=0;
        color[47]=0;
        color[48]=0;
        color[49]=0;
        color[50]=1;
        color[51]=1;
        color[52]=0;
        color[53]=0;
        color[54]=0;
        color[55]=0;
        color[56]=0;
        color[57]=1;
        color[58]=1;
        color[59]=1;
        color[60]=0;
        color[61]=0;
        color[62]=0;
        color[63]=0;
        color[64]=0;
        color[65]=0;
        color[66]=0;
        color[67]=0;
        color[68]=0;
        color[69]=0;
        color[70]=1;
        color[71]=1;
        color[72]=0;
        color[73]=0;
        color[74]=0;
        color[75]=0;
        color[76]=0;
        color[77]=1;
        color[78]=1;
        color[79]=0;
        color[80]=0;
        color[81]=0;
        color[82]=0;
        color[83]=0;
        color[84]=0;
        color[85]=1;
        color[86]=1;
        color[87]=0;
        color[88]=0;
        color[89]=0;
        color[90]=0;
        color[91]=0;
        color[92]=0;
        color[93]=0;
        color[94]=0;
        color[95]=0;
        color[96]=0;
        color[97]=0;
        color[98]=0;
        color[99]=1;
        color[100]=1;
        color[101]=0;
        color[102]=0;
        color[103]=0;
        color[104]=0;
        color[105]=0;
        color[106]=0;
        
        idx1[0]=13'd80; //-48
        idx1[1]=13'd96; 
        idx1[2]=13'd112;  
        idx1[3]=13'd120; 
        idx1[4]=13'd136; 
        idx1[5]=13'd168; 
        idx1[6]=13'd208; 
        idx1[7]=13'd224; 
        idx1[8]=13'd240; 
        idx1[9]=13'd248; 
        idx1[10]=13'd264; 
        idx1[11]=13'd296; 
        idx1[12]=13'd336; 
        idx1[13]=13'd352; 
        idx1[14]=13'd368; 
        idx1[15]=13'd376; 
        idx1[16]=13'd392; 
        idx1[17]=13'd464; 
        idx1[18]=13'd480; 
        idx1[19]=13'd520; 
        idx1[20]=13'd568; 
        idx1[21]=13'd576; 
        idx1[22]=13'd592; 
        idx1[23]=13'd608; 
        idx1[24]=13'd648; 
        idx1[25]=13'd696; 
        idx1[26]=13'd704; 
        idx1[27]=13'd720; 
        idx1[28]=13'd736; 
        idx1[29]=13'd776; 
        idx1[30]=13'd808; 
        idx1[31]=13'd848;
        idx1[32]=13'd864;
        idx1[33]=13'd880;
        idx1[34]=13'd888;
        idx1[35]=13'd904;
        idx1[36]=13'd944;
        idx1[37]=13'd960;
        idx1[38]=13'd976;
        idx1[39]=13'd1104;
        idx1[40]=13'd1184;
        idx1[41]=13'd1216;
        idx1[42]=13'd1232;
        idx1[43]=13'd1456;
        idx1[44]=13'd1472;
        idx1[45]=13'd1488;
        idx1[46]=13'd1556;
        idx1[47]=13'd1712;
        idx1[48]=13'd1744;
        idx1[49]=13'd1768;
        idx1[50]=13'd1968;
        idx1[51]=13'd2000;
        idx1[52]=13'd2048;
        idx1[53]=13'd2080;
        idx1[54]=13'd2128;
        idx1[55]=13'd2176;
        idx1[56]=13'd2224;
        idx1[57]=13'd2256;
        idx1[58]=13'd2304;
        idx1[59]=13'd2336;
        idx1[60]=13'd2384;
        idx1[61]=13'd2432;
        idx1[62]=13'd2480;
        idx1[63]=13'd2512;
        idx1[64]=13'd2560;
        idx1[65]=13'd2640;
        idx1[66]=13'd2688;
        idx1[67]=13'd2768;
        idx1[68]=13'd2780;
        idx1[69]=13'd2840;
        idx1[70]=13'd2852;
        idx1[71]=13'd2912;
        idx1[72]=13'd2936;
        idx1[73]=13'd2960;
        idx1[74]=13'd2984;
        idx1[75]=13'd3008;
        idx1[76]=13'd3040;
        idx1[77]=13'd3088;
        idx1[78]=13'd3232;
        idx1[79]=13'd3268;
        idx1[80]=13'd3296;
        idx1[81]=13'd3344;
        idx1[82]=13'd3424;
        idx1[83]=13'd3448;
        idx1[84]=13'd3536;
        idx1[85]=13'd3552;
        idx1[86]=13'd3680;
        idx1[87]=13'd3704;
        idx1[88]=13'd3808;
        idx1[89]=13'd3856;
        idx1[90]=13'd3936;
        idx1[91]=13'd4000;
        idx1[92]=13'd4064;
        
        color1[0]=1;
        color1[1]=1;
        color1[2]=1;
        color1[3]=0;
        color1[4]=0;
        color1[5]=0;
        color1[6]=1;
        color1[7]=1;
        color1[8]=1;
        color1[9]=0;
        color1[10]=0;
        color1[11]=0;
        color1[12]=0;
        color1[13]=0;
        color1[14]=0;
        color1[15]=1;
        color1[16]=1;
        color1[17]=1;
        color1[18]=1;
        color1[19]=1;
        color1[20]=0;
        color1[21]=0;
        color1[22]=0;
        color1[23]=0;
        color1[24]=0;
        color1[25]=1;
        color1[26]=1;
        color1[27]=1;
        color1[28]=1;
        color1[29]=0;
        color1[30]=0;
        color1[31]=0;
        color1[32]=0;
        color1[33]=0;
        color1[34]=0;
        color1[35]=0;
        color1[36]=1;
        color1[37]=1;
        color1[38]=1;
        color1[39]=0;
        color1[40]=1;
        color1[41]=0;
        color1[42]=1;
        color1[43]=1;
        color1[44]=1;
        color1[45]=1;
        color1[46]=0;
        color1[47]=0;
        color1[48]=0;
        color1[49]=0;
        color1[50]=1;
        color1[51]=0;
        color1[52]=0;
        color1[53]=0;
        color1[54]=1;
        color1[55]=1;
        color1[56]=1;
        color1[57]=0;
        color1[58]=0;
        color1[59]=0;
        color1[60]=1;
        color1[61]=1;
        color1[62]=1;
        color1[63]=0;
        color1[64]=0;
        color1[65]=1;
        color1[66]=1;
        color1[67]=0;
        color1[68]=0;
        color1[69]=1;
        color1[70]=1;
        color1[71]=0;
        color1[72]=0;
        color1[73]=0;
        color1[74]=0;
        color1[75]=1;
        color1[76]=1;
        color1[77]=0;
        color1[78]=0;
        color1[79]=0;
        color1[80]=0;
        color1[81]=0;
        color1[82]=1;
        color1[83]=1;
        color1[84]=0;
        color1[85]=0;
        color1[86]=0;
        color1[87]=0;
        color1[88]=1;
        color1[89]=0;
        color1[90]=0;
        color1[91]=0;
        color1[92]=0;
    end 
    assign clkk=(_music) ? clkDiv19 : clkDivjo;
    always @(posedge clkk,posedge rst) begin
        if(rst) begin
            position[0][0]<=10'd690;
            position[0][1]<=0;
            position[1][0]<=10'd690;
            position[1][1]<=0;
            position[2][0]<=10'd690;
            position[2][1]<=0;
            position[3][0]<=10'd690;
            position[3][1]<=0;
            position[4][0]<=10'd690;
            position[4][1]<=0;
            position[5][0]<=10'd690;
            position[5][1]<=0;
        end
        else if(_music==1) begin
            if(ibeatNum2==idx2[i]-10'd6) begin
                if(position[0][0]==10'd690) begin
                    position[0][0]<=10'd640;
                    position[0][1]<=color[i];
                end
                else begin
                    position[0][0]<=position[0][0]-1;
                    if(position[1][0]==10'd690) begin
                        position[1][0]<=10'd640;
                        position[1][1]<=color[i];            
                    end
                    else begin
                        position[1][0]<=position[1][0]-1;
                        if(position[2][0]==10'd690) begin
                            position[2][0]<=10'd640;
                            position[2][1]<=color[i];            
                        end
                        else begin
                            position[2][0]<=position[2][0]-1;
                            if(position[3][0]==10'd690) begin
                                position[3][0]<=10'd640;
                                position[3][1]<=color[i];            
                            end      
                            else begin
                                position[3][0]<=position[3][0]-1;
                                if(position[4][0]==10'd690) begin
                                    position[4][0]<=10'd640;
                                    position[4][1]<=color[i];            
                                end      
                                else begin
                                    position[4][0]<=position[4][0]-1;
                                    if(position[5][0]==10'd690) begin
                                        position[5][0]<=10'd640;
                                        position[5][1]<=color[i];            
                                    end      
                                    else position[5][0]<=position[5][0]-1;
                                end
                            end
                        end
                    end
                end          
            end
            if(position[0][0]!=10'd690) begin
                if(position[0][0]>10'd210&&good[0]==0) position[0][0]<=position[0][0]-1;
                else begin
                    position[0][0]<=10'd690;
                    //good[0]=0;
                end 
            end
            if(position[1][0]!=10'd690) begin
                if(position[1][0]>10'd210&&good[1]==0) position[1][0]<=position[1][0]-1;
                else begin
                    position[1][0]<=10'd690;
                    //good[1]=0;
                end 
            end
            if(position[2][0]!=10'd690)begin
                if(position[2][0]>10'd210&&good[2]==0) position[2][0]<=position[2][0]-1;
                else begin
                    position[2][0]<=10'd690;
                    //good[2]=0;
                end 
            end
            if(position[3][0]!=10'd690)begin
                if(position[3][0]>10'd210&&good[3]==0) position[3][0]<=position[3][0]-1;
                else begin
                    position[3][0]<=10'd690;
                    //good[3]=0;
                end 
            end 
            if(position[4][0]!=10'd690)begin
                if(position[4][0]>10'd210&&good[4]==0) position[4][0]<=position[4][0]-1;
                else begin
                    position[4][0]<=10'd690;
                    //good[3]=0;
                end 
            end 
            if(position[5][0]!=10'd690)begin
                if(position[5][0]>10'd210&&good[5]==0) position[5][0]<=position[5][0]-1;
                else begin
                    position[5][0]<=10'd690;
                    //good[3]=0;
                end 
            end 
        end
        else begin
            if(ibeatNum==idx1[i2]-10'd6) begin
                if(position[0][0]==10'd690) begin
                    position[0][0]<=10'd640;
                    position[0][1]<=color1[i2];
                end
                else begin
                    position[0][0]<=position[0][0]-1;
                    if(position[1][0]==10'd690) begin
                        position[1][0]<=10'd640;
                        position[1][1]<=color1[i2];            
                    end
                    else begin
                        position[1][0]<=position[1][0]-1;
                        if(position[2][0]==10'd690) begin
                            position[2][0]<=10'd640;
                            position[2][1]<=color1[i2];            
                        end
                        else begin
                            position[2][0]<=position[2][0]-1;
                            if(position[3][0]==10'd690) begin
                                position[3][0]<=10'd640;
                                position[3][1]<=color1[i2];            
                            end      
                            else begin
                                position[3][0]<=position[3][0]-1;
                                if(position[4][0]==10'd690) begin
                                    position[4][0]<=10'd640;
                                    position[4][1]<=color1[i2];            
                                end      
                                else begin
                                    position[4][0]<=position[4][0]-1;
                                    if(position[5][0]==10'd690) begin
                                        position[5][0]<=10'd640;
                                        position[5][1]<=color1[i2];            
                                    end      
                                    else position[5][0]<=position[5][0]-1;
                                end
                            end
                        end
                    end
                end          
            end
            if(position[0][0]!=10'd690) begin
                if(position[0][0]>10'd210&&good[0]==0) position[0][0]<=position[0][0]-1;
                else begin
                    position[0][0]<=10'd690;
                    //good[0]=0;
                end 
            end
            if(position[1][0]!=10'd690) begin
                if(position[1][0]>10'd210&&good[1]==0) position[1][0]<=position[1][0]-1;
                else begin
                    position[1][0]<=10'd690;
                    //good[1]=0;
                end 
            end
            if(position[2][0]!=10'd690)begin
                if(position[2][0]>10'd210&&good[2]==0) position[2][0]<=position[2][0]-1;
                else begin
                    position[2][0]<=10'd690;
                    //good[2]=0;
                end 
            end
            if(position[3][0]!=10'd690)begin
                if(position[3][0]>10'd210&&good[3]==0) position[3][0]<=position[3][0]-1;
                else begin
                    position[3][0]<=10'd690;
                    //good[3]=0;
                end 
            end 
            if(position[4][0]!=10'd690)begin
                if(position[4][0]>10'd210&&good[4]==0) position[4][0]<=position[4][0]-1;
                else begin
                    position[4][0]<=10'd690;
                    //good[3]=0;
                end 
            end 
            if(position[5][0]!=10'd690)begin
                if(position[5][0]>10'd210&&good[5]==0) position[5][0]<=position[5][0]-1;
                else begin
                    position[5][0]<=10'd690;
                    //good[3]=0;
                end 
            end 
        end
    end
    always @* begin
        if(_music==1&&ibeatNum2==idx2[i]-10'd6) begin
            if(i<10'd106) i_next=i+1;
            else i_next=0;
        end 
        else i_next=i;
        if(_music==0&&ibeatNum==idx1[i2]-10'd6) begin
            if(i2<10'd92) i2_next=i2+1;
            else i2_next=0;
        end 
        else i2_next=i2;
    end
    always @(posedge clkk,posedge rst) begin
        if(rst) begin
            i<=0;
            i2<=0;
        end
        else if(_music==1) begin
            i<=i_next;
        end
        else if(_music==0) begin
            i2<=i2_next;
        end
    end

    assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;

     clock_divider clk_wiz_0_inst(
      .clk(clk),
      .clk1(clk_25MHz),
      .clk22(clk_22)
    );

    mem_addr_gen mem_addr_gen_inst(
    .clk(clkDivjojo),
    .rst(rst),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .pixel_addr(pixel_addr),
    .p0(position[0][0]),
    .c0(position[0][1]),
    .p1(position[1][0]),
    .c1(position[1][1]),
    .p2(position[2][0]),
    .c2(position[2][1]),
    .p3(position[3][0]),
    .c3(position[3][1]),
    .p4(position[4][0]),
    .c4(position[4][1]),
    .p5(position[5][0]),
    .c5(position[5][1])
    );
     
 
    blk_mem_gen_0 blk_mem_gen_0_inst(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr),
      .dina(data[11:0]),
      .douta(pixel)
    ); 

    vga_controller   vga_inst(
      .pclk(clk_25MHz),
      .reset(rst),
      .hsync(hsync),
      .vsync(vsync),
      .valid(valid),
      .h_cnt(h_cnt),
      .v_cnt(v_cnt)
    );
    // Internal Signal
        wire [15:0] audio_in_left, audio_in_right;

        
    
        
        wire [31:0] freqL, freqR,freqL2,freqR2;           // Raw frequency, produced by music module
        wire [21:0] freq_outL, freq_outR;    // Processed frequency, adapted to the clock rate of Basys3
    
        // clkDiv22
        
        wire deone_clk;
        clock_divider_2 #(.n(22)) clock_22(.clk(clk), .clk_div(clkDiv22));    // for keyboard and lihong
        clock_divider_2 #(.n(19)) clock_19(.clk(clk), .clk_div(clkDiv19));
        clock_divider_2 #(.n(15)) clock_de(.clk(clk), .clk_div(deone_clk));   
        clock_divider_2 #(.n(17)) clock_re(.clk(clk), .clk_div(refresh_clk));
        clock_divider_specified #(.n(15*10**5)) clock_jojo(.clk(clk), .clk_div(clkDivjojo));    //for jojo
        clock_divider_specified #(.n(1875*10**2)) clock_jo(.clk(clk), .clk_div(clkDivjo));    //for jojo
    
        wire [511:0] key_down;
        wire [8:0] last_change;
        wire been_ready;
    
        parameter C=9'b0_0001_1100; //1C
        parameter D=9'b0_0001_1011; //1B
        parameter E=9'b0_0010_0011; //23
        parameter F=9'b0_0010_1011; //2B
        parameter G=9'b0_0011_0100; //34
        parameter A=9'b0_0011_0011; //33
        parameter B=9'b0_0011_1011; //3B
        parameter r=9'b0_0110_1001;  //1
        parameter b=9'b0_0111_1010;  //3
    
        reg [31:0] keyR,keyL;
        
        initial begin
            keyR=`sil;
            keyL=`sil;
        end
    
        reg [3:0] outsign;
        reg [3:0] BCD3,BCD2,BCD1,BCD0;
    
        reg [2:0] volume;
        wire _volUP_d,_volDOWN_d,_volUP_o,_volDOWN_o;
        wire ok_d,ok_o;
    
        debounce d1 (.pb_debounced(_volUP_d), .pb(_volUP) ,.clk(deone_clk));
        debounce d2 (.pb_debounced(_volDOWN_d), .pb(_volDOWN) ,.clk(deone_clk));
        debounce d3 (.pb_debounced(ok_d), .pb(ok) ,.clk(deone_clk));
        onepulse o1 (.signal(_volUP_d), .clk(deone_clk), .op(_volUP_o));
        onepulse o2 (.signal(_volDOWN_d), .clk(deone_clk), .op(_volDOWN_o));
        onepulse o3 (.signal(ok_d), .clk(deone_clk), .op(ok_o));
    
        initial begin
          //  _led[12:5]=8'b0000_0000;
            volume<=3'd3;
        end
    
        always @(posedge deone_clk,posedge rst)
        begin
            if(rst)
                volume<=3'd3;
            else
            begin
                if(_volUP_o)        //volume up
                begin
                    if(volume==3'd5)
                        volume<=3'd5;
                    else
                        volume<=volume+3'd1;
                end
                else if(_volDOWN_o)     //volume down
                begin
                    if(volume==3'd1)
                        volume<=3'd1;
                    else
                        volume<=volume-3'd1;
                end
            end
        end

        reg start1,start2;
    
        // Player Control
        // [in]  reset, clock, _play, _slow, _music, and _mode
        // [out] beat number
        player_control playerCtrl_00 (  //jojo
            .clk(clkDivjojo),
            .reset(rst),
            ._play(_play),
            ._slow(_slow), 
            ._mode(_mode),
            ._music(_music),               //_music==0
            .ok_o(ok_o),
            .start1(start1),
            .ibeat(ibeatNum)
        );
    
        player_control2 playerCtrl_02 (     //things you don't know
            .clk(clkDiv22),
            .reset(rst),
            ._play(_play),
            ._slow(_slow), 
            ._mode(_mode),
            ._music(_music),                //_music==1
            .ok_o(ok_o),
            .start2(start2),
            .ibeat(ibeatNum2)
        );
    
        // Music module
        // [in]  beat number and en
        // [out] left & right raw frequency
        music_example music_00 (            //jojo 
            .ibeatNum(ibeatNum),
            .en(1'b1),
            ._mode(_mode),
            .toneL(freqL),
            .toneR(freqR)
        );
    
        music_example2 music_02 (          //things you don't know
            .ibeatNum(ibeatNum2),
            .en(1'b1),
            ._mode(_mode),
            .toneL(freqL2),
            .toneR(freqR2)
        );
        
        reg [3:0] value0,value1,value2,value3;
        //play mode
        always @(posedge clk,posedge rst)
        begin
            if(rst) //changed
            begin
            good<=6'd0;
            value0<=0;
            value1<=0;
            value2<=0;
            value3<=0;
            end
            else if(ok_o)begin
            value0<=0;
            value1<=0;
            value2<=0;
            value3<=0;
            end
            else
            begin
                if(_mode)  //demonstrate mode
                begin
                    if(been_ready)
                    begin
                        if(position[0][0]==10'd690) begin
                            _led<=16'd0;
                            good[0]<=0;end
                        if(position[1][0]==10'd690)begin
                            _led<=16'd0;
                            good[1]<=0;end                         
                        if(position[2][0]==10'd690)begin
                            _led<=16'd0;
                            good[2]<=0;end                         
                        if(position[3][0]==10'd690)begin
                            _led<=16'd0;
                            good[3]<=0;end
                        if(position[4][0]==10'd690)begin
                            _led<=16'd0;
                            good[4]<=0;end
                        if(position[5][0]==10'd690)begin
                            _led<=16'd0;
                            good[5]<=0;end
                        if(key_down[r])
                        begin
                           if(position[0][0]<10'd260&&position[0][1]==0) begin
                               good[0]<=1;
                               if(position[0][0]<10'd230&&position[0][0]>10'd220&&position[0][1]==0) begin
                                  _led<=16'b1111_1111_1111_1111;
                                  if(value3>=4'd5) begin
                                     if(value2<4'd9) value2<=value2+1;
                                     else begin
                                       value2<=0;
                                       value1<=value1+1;
                                     end 
                                     value3<=value3-4'd5;
                                  end 
                                  else value3<=value3+4'd5;
                               end
                               else begin
                                   _led<=16'b0000_1111_1111_0000;
                                   if(value3>=4'd7) begin
                                      if(value2<4'd9) value2<=value2+1;
                                      else begin
                                        value2<=0;
                                        value1<=value1+1;
                                      end 
                                      value3<=value3-4'd7;
                                   end 
                                   else value3<=value3+4'd3;
                               end
                               
                           end
                           else if(position[1][0]<10'd260&&position[1][1]==0) begin
                               good[1]<=1;
                               if(position[1][0]<10'd230&&position[1][0]>10'd220&&position[1][1]==0) begin
                                     _led<=16'b1111_1111_1111_1111;
                                     if(value3>=4'd5) begin
                                        if(value2<4'd9) value2<=value2+1;
                                        else begin
                                          value2<=0;
                                          value1<=value1+1;
                                        end 
                                        value3<=value3-4'd5;
                                     end 
                                     else value3<=value3+4'd5;
                                  end
                               else begin
                                   _led<=16'b0000_1111_1111_0000;
                                   if(value3>=4'd7) begin
                                      if(value2<4'd9) value2<=value2+1;
                                      else begin
                                        value2<=0;
                                        value1<=value1+1;
                                      end 
                                      value3<=value3-4'd7;
                                   end 
                                   else value3<=value3+4'd3;
                               end
                           end
                           else if(position[2][0]<10'd260&&position[2][1]==0) begin
                               good[2]=1;
                               if(position[2][0]<10'd230&&position[2][0]>10'd220&&position[2][1]==0) begin
                                 _led<=16'b1111_1111_1111_1111;
                                 if(value3>=4'd5) begin
                                    if(value2<4'd9) value2<=value2+1;
                                    else begin
                                      value2<=0;
                                      value1<=value1+1;
                                    end 
                                    value3<=value3-4'd5;
                                 end 
                                 else value3<=value3+4'd5;
                              end
                              else begin
                                   _led<=16'b0000_1111_1111_0000;
                                   if(value3>=4'd7) begin
                                     if(value2<4'd9) value2<=value2+1;
                                     else begin
                                        value2<=0;
                                        value1<=value1+1;
                                      end 
                                      value3<=value3-4'd7;
                                   end 
                                   else value3<=value3+4'd3;
                               end
                           end
                           else if(position[3][0]<10'd260&&position[3][1]==0) begin
                               good[3]=1;
                               if(position[3][0]<10'd230&&position[3][0]>10'd220&&position[3][1]==0) begin
                                     _led<=16'b1111_1111_1111_1111;
                                     if(value3>=4'd5) begin
                                        if(value2<4'd9) value2<=value2+1;
                                        else begin
                                          value2<=0;
                                          value1<=value1+1;
                                        end 
                                        value3<=value3-4'd5;
                                     end 
                                     else value3<=value3+4'd5;
                                  end
                               else begin
                                   _led<=16'b0000_1111_1111_0000;
                                   if(value3>=4'd7) begin
                                     if(value2<4'd9) value2<=value2+1;
                                     else begin
                                        value2<=0;
                                        value1<=value1+1;
                                      end 
                                      value3<=value3-4'd7;
                                   end 
                                   else value3<=value3+4'd3;
                               end
                           end
                           else if(position[4][0]<10'd260&&position[4][1]==0) begin
                               good[4]=1;
                               if(position[4][0]<10'd230&&position[4][0]>10'd220&&position[4][1]==0) begin
                                     _led<=16'b1111_1111_1111_1111;
                                     if(value3>=4'd5) begin
                                        if(value2<4'd9) value2<=value2+1;
                                        else begin
                                          value2<=0;
                                          value1<=value1+1;
                                        end 
                                        value3<=value3-4'd5;
                                     end 
                                     else value3<=value3+4'd5;
                                  end
                               else begin
                                   _led<=16'b0000_1111_1111_0000;
                                   if(value3>=4'd7) begin
                                     if(value2<4'd9) value2<=value2+1;
                                     else begin
                                       value2<=0;
                                       value1<=value1+1;
                                     end 
                                     value3<=value3-4'd7;
                                   end 
                                   else value3<=value3+4'd3;
                               end
                           end
                           else if(position[5][0]<10'd260&&position[5][1]==0) begin
                               good[5]=1;
                               if(position[5][0]<10'd230&&position[5][0]>10'd220&&position[5][1]==0) begin
                                     _led<=16'b1111_1111_1111_1111;
                                     if(value3>=4'd5) begin
                                        if(value2<4'd9) value2<=value2+1;
                                        else begin
                                          value2<=0;
                                          value1<=value1+1;
                                        end 
                                        value3<=value3-4'd5;
                                     end 
                                     else value3<=value3+4'd5;
                                  end
                               else begin
                                   _led<=16'b0000_1111_1111_0000;
                                   if(value3>=4'd7) begin
                                     if(value2<4'd9) value2<=value2+1;
                                     else begin
                                       value2<=0;
                                       value1<=value1+1;
                                     end 
                                     value3<=value3-4'd7;
                                   end 
                                   else value3<=value3+4'd3;
                               end
                           end
                        end
                        else if(key_down[b])
                        begin
                           if(position[0][0]<10'd260&&position[0][1]==1) begin
                               good[0]<=1;
                               if(position[0][0]<10'd230&&position[0][0]>10'd220) begin
                                     _led<=16'b1111_1111_1111_1111;
                                     if(value3>=4'd5) begin
                                        if(value2<4'd9) value2<=value2+1;
                                        else begin
                                          value2<=0;
                                          value1<=value1+1;
                                        end 
                                        value3<=value3-4'd5;
                                     end 
                                     else value3<=value3+4'd5;
                                  end
                               else begin
                                   _led<=16'b0000_1111_1111_0000;
                                   if(value3>=4'd7) begin
                                      if(value2<4'd9) value2<=value2+1;
                                      else begin
                                        value2<=0;
                                        value1<=value1+1;
                                      end 
                                      value3<=value3-4'd7;
                                   end 
                                   else value3<=value3+4'd3;
                               end
                           end
                           else if(position[1][0]<10'd260&&position[1][1]==1) begin
                               good[1]<=1;
                               if(position[1][0]<10'd230&&position[1][0]>10'd220) begin
                                    _led<=16'b1111_1111_1111_1111;
                                    if(value3>=4'd5) begin
                                       if(value2<4'd9) value2<=value2+1;
                                       else begin
                                         value2<=0;
                                         value1<=value1+1;
                                       end 
                                       value3<=value3-4'd5;
                                    end 
                                    else value3<=value3+4'd5;
                                 end
                               else begin
                                   _led<=16'b0000_1111_1111_0000;
                                   if(value3>=4'd7) begin
                                     if(value2<4'd9) value2<=value2+1;
                                      else begin
                                        value2<=0;
                                        value1<=value1+1;
                                      end 
                                      value3<=value3-4'd7;
                                   end 
                                   else value3<=value3+4'd3;
                               end
                           end
                           else if(position[2][0]<10'd260&&position[2][1]==1) begin
                               good[2]=1;
                               if(position[2][0]<10'd230&&position[2][0]>10'd220) begin
                                    _led<=16'b1111_1111_1111_1111;
                                    if(value3>=4'd5) begin
                                       if(value2<4'd9) value2<=value2+1;
                                       else begin
                                         value2<=0;
                                         value1<=value1+1;
                                       end 
                                       value3<=value3-4'd5;
                                    end 
                                    else value3<=value3+4'd5;
                                 end
                               else begin
                                   _led<=16'b0000_1111_1111_0000;
                                   if(value3>=4'd7) begin
                                     if(value2<4'd9) value2<=value2+1;
                                     else begin
                                        value2<=0;
                                        value1<=value1+1;
                                      end 
                                      value3<=value3-4'd7;
                                   end 
                                   else value3<=value3+4'd3;
                               end
                           end
                           else if(position[3][0]<10'd260&&position[3][1]==1) begin
                               good[3]=1;
                               if(position[3][0]<10'd230&&position[3][0]>10'd220) begin
                                    _led<=16'b1111_1111_1111_1111;
                                    if(value3>=4'd5) begin
                                       if(value2<4'd9) value2<=value2+1;
                                       else begin
                                         value2<=0;
                                         value1<=value1+1;
                                       end 
                                       value3<=value3-4'd5;
                                    end 
                                    else value3<=value3+4'd5;
                                 end
                               else begin
                                   _led<=16'b0000_1111_1111_0000;
                                   if(value3>=4'd7) begin
                                     if(value2<4'd9) value2<=value2+1;
                                     else begin
                                       value2<=0;
                                       value1<=value1+1;
                                     end 
                                     value3<=value3-4'd7;
                                   end 
                                   else value3<=value3+4'd3;
                               end
                           end
                           else if(position[4][0]<10'd260&&position[4][1]==1) begin
                               good[4]=1;
                               if(position[4][0]<10'd230&&position[4][0]>10'd220) begin
                                    _led<=16'b1111_1111_1111_1111;
                                    if(value3>=4'd5) begin
                                       if(value2<4'd9) value2<=value2+1;
                                       else begin
                                         value2<=0;
                                         value1<=value1+1;
                                       end 
                                       value3<=value3-4'd5;
                                    end 
                                    else value3<=value3+4'd5;
                                 end
                               else begin
                                   _led<=16'b0000_1111_1111_0000;
                                   if(value3>=4'd7) begin
                                     if(value2<4'd9) value2<=value2+1;
                                     else begin
                                       value2<=0;
                                       value1<=value1+1;
                                     end 
                                     value3<=value3-4'd7;
                                   end 
                                   else value3<=value3+4'd3;
                               end
                           end
                           else if(position[5][0]<10'd260&&position[5][1]==1) begin
                               good[5]=1;
                               if(position[5][0]<10'd230&&position[5][0]>10'd220) begin
                                    _led<=16'b1111_1111_1111_1111;
                                    if(value3>=4'd5) begin
                                       if(value2<4'd9) value2<=value2+1;
                                       else begin
                                         value2<=0;
                                         value1<=value1+1;
                                       end 
                                       value3<=value3-4'd5;
                                    end 
                                    else value3<=value3+4'd5;
                                 end
                               else begin
                                   _led<=16'b0000_1111_1111_0000;
                                   if(value3>=4'd7) begin
                                     if(value2<4'd9) value2<=value2+1;
                                     else begin
                                       value2<=0;
                                       value1<=value1+1;
                                     end 
                                     value3<=value3-4'd7;
                                   end 
                                   else value3<=value3+4'd3;
                               end
                           end
                        end
                    end
                end
            end
        end
    
        // freq_outL, freq_outR
        // Note gen makes no sound, if freq_out = 50000000 / `silence = 1
        assign freq_outL = (_mute)?50000000/`silence :( (_mode)?((_music)?((start2)?50000000 / freqL2:50000000/`silence):((start1)?50000000 / freqL:50000000/`silence)) : 50000000 / keyL);
        assign freq_outR = (_mute)?50000000/`silence :( (_mode)?((_music)?((start2)?50000000 / freqR2:50000000/`silence):((start1)?50000000 / freqR:50000000/`silence)) : 50000000 / keyR); 
    

        
	    always @(posedge clk,posedge rst)
	    begin
		if(rst)begin
			start1<=0;
		end
		else begin
			if(ok_o && !_music)
			start1<=1;
			else if(ibeatNum==13'd4160)
			start1<=0;
            end
	    end

	    always @(posedge clk,posedge rst)
	    begin
		if(rst)begin
			start2<=0;
		end
		else begin
			if(ok_o && _music)
			start2<=1;
			else if(ibeatNum2==13'd3136) //changed
			start2<=0;
            end
	    end
        // Note generation
        // [in]  processed frequency
        // [out] audio wave signal (using square wave here)
        note_gen noteGen_00(    //buzzer control
            .clk(clk), 
            .rst(rst), 
            .volume(volume),
            .note_div_left(freq_outL), 
            .note_div_right(freq_outR), 
            .audio_left(audio_in_left),     // left sound audio
            .audio_right(audio_in_right)    // right sound audio
        );
    
        // Speaker controller
        speaker_control sc(
            .clk(clk), 
            .rst(rst), 
            .audio_in_left(audio_in_left),      // left channel audio data input
            .audio_in_right(audio_in_right),    // right channel audio data input
            .audio_mclk(audio_mclk),            // master clock
            .audio_lrck(audio_lrck),            // left-right clock
            .audio_sck(audio_sck),              // serial clock
            .audio_sdin(audio_sdin)             // serial audio data input
        );
    
        KeyboardDecoder k1(
        .rst(rst),
        .clk(clk),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(been_ready)
        );
    
        always @(posedge refresh_clk)
        begin
            case(DIGIT)
            4'b1110:
            begin
                outsign<=value2;   
                DIGIT<=4'b1101;  
            end
            4'b1101:
            begin
                outsign<=value1;
                DIGIT<=4'b1011;
            end
            4'b1011:
            begin
                outsign<=value0;
                DIGIT<=4'b0111;
            end
            4'b0111:
            begin
                outsign<=value3;
                DIGIT<=4'b1110;
            end
            default:
            begin
                outsign<=value3;
                DIGIT<=4'b1110;
            end
            endcase
        end
    
        //combinational
        always @*
        begin
            case(outsign)
            4'd0: DISPLAY=7'b100_0000;
            4'd1: DISPLAY=7'b111_1001;
            4'd2: DISPLAY=7'b010_0100;
            4'd3: DISPLAY=7'b011_0000;
            4'd4: DISPLAY=7'b001_1001;
            4'd5: DISPLAY=7'b001_0010;
            4'd6: DISPLAY=7'b000_0010;
            4'd7: DISPLAY=7'b111_1000;
            4'd8: DISPLAY=7'b000_0000;
            4'd9: DISPLAY=7'b001_0000;
            4'd10:DISPLAY=7'b011_1111;  //dash
            default: DISPLAY='b111_1111; //none
            endcase
        end
    
    
endmodule    

    module clock_divider_2(clk, clk_div);   
        parameter n = 26;     
        input clk;   
        output clk_div;   
        
        reg [n-1:0] num;
        wire [n-1:0] next_num;
        
        always@(posedge clk)begin
            num<=next_num;
        end
        
        assign next_num = num +1;
        assign clk_div = num[n-1];
        
    endmodule
    
    module clock_divider_specified
    #(parameter n=28'd10**8)    //1hz
    (input clk,
    output reg clk_div);
    
    reg [27:0] counter=0;
    
    always @(posedge clk)
    begin
        counter<=counter+28'd1;
        if(counter>=(n-1))
        counter<=0;     
        clk_div<=(counter<n/2)?1'b1:1'b0;
    end
    endmodule  