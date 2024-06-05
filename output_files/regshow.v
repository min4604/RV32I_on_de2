module	regshow(	
input	iCLK,
input	iRST_N,
output	[7:0]LCD_DATA,
output	LCD_RW,
output	LCD_EN,
output	LCD_RS,
inout [1:0]wordsw,

input reset


);

//	Internal Wires/Registers
reg	[5:0]	LUT_INDEX;
reg	[8:0]	LUT_DATA;
reg	[5:0]	mLCD_ST;
reg	[17:0]	mDLY;
reg			mLCD_Start;
reg	[7:0]	mLCD_DATA;
reg			mLCD_RS;
wire		mLCD_Done;
reg ress;
reg [18:0] div;
reg [ 4:0] delay_res;
reg	[19:0]	Cont;
wire resa;
parameter	LUT_SIZE	=	39;//LCD_LINE	+32+1;


reg [15:0] regAaddr;
reg [55:0] datA;
reg [15:0] regBaddr;
reg [55:0] datB;

always@(posedge iCLK)
begin
	if(!resa)
	begin
		LUT_INDEX	<=	0;
		mLCD_ST		<=	0;
		mDLY		<=	0;
		mLCD_Start	<=	0;
		mLCD_DATA	<=	0;
		mLCD_RS		<=	0;
	end
	else
	begin
		if(LUT_INDEX<LUT_SIZE)
		begin
			case(mLCD_ST)
			0:	begin
					mLCD_DATA	<=	LUT_DATA[7:0];
					mLCD_RS		<=	LUT_DATA[8];
					mLCD_Start	<=	1;
					mLCD_ST		<=	1;
				end
			1:	begin
					if(mLCD_Done)
					begin
						mLCD_Start	<=	0;
						mLCD_ST		<=	2;					
					end
				end
			2:	begin
					if(mDLY<18'h3FFFE)
					mDLY	<=	mDLY+1;
					else
					begin
						mDLY	<=	0;
						mLCD_ST	<=	3;
					end
				end
			3:	begin
					LUT_INDEX	<=	LUT_INDEX+1;
					mLCD_ST	<=	0;
				end
			endcase
		end
	end
end


always@(posedge iCLK) begin
if (!reset) begin
	case(LUT_INDEX)
	 0:	LUT_DATA	<=	9'h038;
	 1:	LUT_DATA	<=	9'h00C;
	 2:	LUT_DATA	<=	9'h001;
	 3:	LUT_DATA	<=	9'h006;
	 4:	LUT_DATA	<=	9'h080;
	 5:	LUT_DATA	<=	9'h120;// 
	 6:	LUT_DATA	<=	9'h120;//F
	 7:	LUT_DATA	<=	9'h120;//L
	 8:	LUT_DATA	<=	9'h120;//A
	 9:	LUT_DATA	<=	9'h120;//S
   10:	LUT_DATA	<=	9'h120;//H
   11:	LUT_DATA	<=	9'h120;// 
	12:	LUT_DATA	<=	9'h120;// 
	13:	LUT_DATA	<=	9'h120;// 
	14:	LUT_DATA	<=	9'h120;//W
	15:	LUT_DATA	<=	9'h120;//R
	16:	LUT_DATA	<=	9'h120;//I
	17:	LUT_DATA	<=	9'h120;//T
	18:	LUT_DATA	<=	9'h120;//E
	19:	LUT_DATA	<=	9'h120;//R
	20:	LUT_DATA	<=	9'h120;// 

	21:	LUT_DATA	<=	9'h0c0;
	
	22:	LUT_DATA	<=	9'h120;// 
	23:	LUT_DATA	<=	9'h120;//F
	24:	LUT_DATA	<=	9'h120;//L
	25:	LUT_DATA	<=	9'h120;//A
	26:	LUT_DATA	<=	9'h120;//S
   27:	LUT_DATA	<=	9'h120;//H
   28:	LUT_DATA	<=	9'h120;// 
	29:	LUT_DATA	<=	9'h120;// 
	30:	LUT_DATA	<=	9'h120;// 
	31:	LUT_DATA	<=	9'h120;//W
	32:	LUT_DATA	<=	9'h120;//R
	33:	LUT_DATA	<=	9'h120;//I
	34:	LUT_DATA	<=	9'h120;//T
	35:	LUT_DATA	<=	9'h120;//E
	36:	LUT_DATA	<=	9'h120;//R
	37:	LUT_DATA	<=	9'h120;// 
	default :LUT_DATA	<=	9'h120;//
	endcase	
end else	 begin
	0:	LUT_DATA	<=	9'h038;
	 1:	LUT_DATA	<=	9'h00C;
	 2:	LUT_DATA	<=	9'h001;
	 3:	LUT_DATA	<=	9'h006;
	 4:	LUT_DATA	<=	9'h080;
	 5:	LUT_DATA	<=	9'h152;// 
	 6:	LUT_DATA	<=	9'h131;//R
	 7:	LUT_DATA	<=	9'h13a;//e
	 8:	LUT_DATA	<=	{1'b1,regAaddr[15:8]};//g
	 9:	LUT_DATA	<=	{1'b1,regAaddr[7:0]};//1
   10:	LUT_DATA	<=	9'h120;//:
   11:	LUT_DATA	<=	9'h144;// 0
	12:	LUT_DATA	<=	9'h13A;// x
	13:	LUT_DATA	<=	{1'b1,datA[55:48]};// 
	14:	LUT_DATA	<=	{1'b1,datA[47:40]};//W
	15:	LUT_DATA	<=	{1'b1,datA[39:32]};//R
	16:	LUT_DATA	<=	{1'b1,datA[31:24]};//I
	17:	LUT_DATA	<=	{1'b1,datA[23:16]};//T
	18:	LUT_DATA	<=	{1'b1,datA[15:8]};//E
	19:	LUT_DATA	<=	{1'b1,datA[7:0]};//R
	20:	LUT_DATA	<=	9'h120;// 

	21:	LUT_DATA	<=	9'h0c0;
	
	22:	LUT_DATA	<=	9'h152;// 
	23:	LUT_DATA	<=	9'h132;//F
	24:	LUT_DATA	<=	9'h13a;//L
	25:	LUT_DATA	<=	{1'b1,regBaddr[15:8]};//A
	26:	LUT_DATA	<=	{1'b1,regBaddr[15:8]};//S
   27:	LUT_DATA	<=	9'h120;//H
   28:	LUT_DATA	<=	9'h144;// 
	29:	LUT_DATA	<=	9'h13A;// 
	30:	LUT_DATA	<=	{1'b1,datB[55:48]};// 
	31:	LUT_DATA	<=	{1'b1,datB[47:40]};//W
	32:	LUT_DATA	<=	{1'b1,datB[39:32]};//R
	33:	LUT_DATA	<=	{1'b1,datB[31:24]};//I
	34:	LUT_DATA	<=	{1'b1,datB[23:16]};//T
	35:	LUT_DATA	<=	{1'b1,datB[15:8]};//E
	36:	LUT_DATA	<=	{1'b1,datB[7:0]};//R
	37:	LUT_DATA	<=	9'h120;// 
	default :LUT_DATA	<=	9'h120;//
	end
end

always @ (posedge iCLK ) begin
	div = div+1;
end



always@(posedge iCLK)
begin
	if(!flashing) begin
		if(Cont!=20'hFFFFF)
		begin
			Cont	<=	Cont+1;
			ress	<=	1'b0;
		end
		else begin
		ress	<=	1'b1;
		end
	end else begin
		Cont <= 0;
		ress	<=	1'b1;
	end
		
		
end

assign resa = ress & iRST_N;

LCD_Controller 		u0	(	//	Host Side
							.iDATA(mLCD_DATA),
							.iRS(mLCD_RS),
							.iStart(mLCD_Start),
							.oDone(mLCD_Done),
							.iCLK(iCLK),
							.iRST_N(resa),
							//	LCD Interface
							.LCD_DATA(LCD_DATA),
							.LCD_RW(LCD_RW),
							.LCD_EN(LCD_EN),
							.LCD_RS(LCD_RS)	);


	function [7:0] changtolcd;
		input [3:0] dt;
			case(dt)
			4'h0: changtolcd = 9'h130;
			4'h1: changtolcd = 9'h131;
			4'h2: changtolcd = 9'h132;
			4'h3: changtolcd = 9'h133;
			4'h4: changtolcd = 9'h134;
			4'h5: changtolcd = 9'h135;
			4'h6: changtolcd = 9'h136;
			4'h7: changtolcd = 9'h137;
			4'h8: changtolcd = 9'h138;
			4'h9: changtolcd = 9'h139;
			4'hA: changtolcd = 9'h141;
			4'hB: changtolcd = 9'h142;
			4'hC: changtolcd = 9'h143;
			4'hD: changtolcd = 9'h144;
			4'hE: changtolcd = 9'h145;
			4'hF: changtolcd = 9'h146;
			endcase
	endfunction;
							
endmodule


