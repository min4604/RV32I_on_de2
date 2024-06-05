module	regshow(	
input	iCLK,
output	[7:0]LCD_DATA,
output	LCD_RW,
output	LCD_EN,
output	LCD_RS,
input [1:0]mode,
input [31:0] rs1,
input [31:0] rs2,
input [4:0] ra1,
input [4:0] ra2,
input [31:0] prog,
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
reg ressauto;
reg [27:0] div;
reg [ 4:0] delay_res;
reg	[19:0]	Cont;
reg	[19:0]	Cont1;
wire resa;
parameter	LUT_SIZE	=	39;//LCD_LINE	+32+1;
wire iRST_N;



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
	 5:	LUT_DATA	<=	9'h131;// 
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
	
	22:	LUT_DATA	<=	9'h152;// R
	23:	LUT_DATA	<=	9'h132;//2
	24:	LUT_DATA	<=	9'h13a;//:
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
	case(mode)
		0: begin
			case(LUT_INDEX)
				  0:	LUT_DATA	<=	9'h038;
				 1:	LUT_DATA	<=	9'h00C;
				 2:	LUT_DATA	<=	9'h001;
				 3:	LUT_DATA	<=	9'h006;
				 4:	LUT_DATA	<=	9'h080;
				 5:	LUT_DATA	<=	9'h152;// R
				 6:	LUT_DATA	<=	9'h131;//1
				 7:	LUT_DATA	<=	9'h13a;//:
				 8:	LUT_DATA	<=	changtolcd({3'b000,ra1[4]});//g
				 9:	LUT_DATA	<=	changtolcd(ra1[3:0]);//1
				10:	LUT_DATA	<=	9'h120;// 
				11:	LUT_DATA	<=	9'h144;// D
				12:	LUT_DATA	<=	9'h13A;// :
				13:	LUT_DATA	<=	changtolcd(rs1[31:28]);// 
				14:	LUT_DATA	<=	changtolcd(rs1[27:24]);//W
				15:	LUT_DATA	<=	changtolcd(rs1[23:20]);//R
				16:	LUT_DATA	<=	changtolcd(rs1[19:16]);//I
				17:	LUT_DATA	<=	changtolcd(rs1[15:12]);//T
				18:	LUT_DATA	<=	changtolcd(rs1[11:8]);//E
				19:	LUT_DATA	<=	changtolcd(rs1[7:4]);//R
				20:	LUT_DATA	<=	changtolcd(rs1[3:0]);// 

				21:	LUT_DATA	<=	9'h0c0;
				
				22:	LUT_DATA	<=	9'h152;// R
				23:	LUT_DATA	<=	9'h132;//2
				24:	LUT_DATA	<=	9'h13a;//:
				25:	LUT_DATA	<=	changtolcd({3'b000,ra2[4]});//A
				26:	LUT_DATA	<=	changtolcd(ra2[3:0]);//S
				27:	LUT_DATA	<=	9'h120;//H
				28:	LUT_DATA	<=	9'h144;// 
				29:	LUT_DATA	<=	9'h13A;// 
				30:	LUT_DATA	<=	changtolcd(rs2[31:28]);// 
				31:	LUT_DATA	<=	changtolcd(rs2[27:24]);//W
				32:	LUT_DATA	<=	changtolcd(rs2[23:20]);//R
				33:	LUT_DATA	<=	changtolcd(rs2[19:16]);//I
				34:	LUT_DATA	<=	changtolcd(rs2[15:12]);//T
				35:	LUT_DATA	<=	changtolcd(rs2[11:8]);//E
				36:	LUT_DATA	<=	changtolcd(rs2[7:4]);//R
				37:	LUT_DATA	<=	changtolcd(rs2[3:0]);// 
				default :LUT_DATA	<=	9'h120;//
			endcase
		end
		
		default : LUT_DATA	<=	9'h120;
	endcase
end
end

always @ (posedge iCLK ) begin
	div = div+1;
end


always@(posedge iCLK)
begin
	if(!(reset)) begin
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
always @(posedge iCLK) begin
	if(!div[24]) begin
		if(Cont1!=20'hFFFFF)
		begin
			Cont1	<=	Cont1+1;
			ressauto	<=	1'b0;
		end
		else begin
		ressauto	<=	1'b1;
		end
	end else begin
		Cont1 <= 0;
		ressauto	<=	1'b1;
	end
end

assign resa = ress  & ressauto;
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


	function [8:0] changtolcd;
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
			default : changtolcd =9'h120;
			endcase
	endfunction
							
endmodule


