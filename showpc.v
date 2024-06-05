module showpc(
	input [31:0] pc,
	output [6:0] segA,
	output [6:0] segB
	
);


reg [7:0] bcd;
reg [31:0] pcc;
	always @(pc) begin
		pcc ={2'b00,pc[31:2]};
		bcd[7:4] = pcc/10;
		bcd[3:0] = pcc%10;
	end

	segdec segAA(bcd[7:4],segB);
	segdec segBB(bcd[3:0],segA);

endmodule	

module segdec(
	input [3:0] bcd,
	output reg[6:0] OUT
);

	always@(bcd) begin
		case(bcd)
			4'h0 : OUT <= 7'b0000001;
			4'h1 : OUT <= 7'b1001111;
			4'h2 : OUT <= 7'b0010010;
			4'h3 : OUT <= 7'b0000110;
			4'h4 : OUT <= 7'b1001100;
			4'h5 : OUT <= 7'b0100100;
			4'h6 : OUT <= 7'b0100000;
			4'h7 : OUT <= 7'b0001111;
			4'h8 : OUT <= 7'b0000000;
			4'h9 : OUT <= 7'b0000100;
			default : OUT <= 7'b1111111;
		endcase
	end

endmodule

