module debonce(
	input clk,
	input key,
	output reg keyout
);

reg [25:1] div;
reg [3:0] count;

always @ (posedge clk) begin
	div = div + 1'b1;
end

always @ (posedge div[18]) begin
	if(key == 1'b0) begin
		if(count <4'b101) begin
			count <= count+1'b1;
			keyout <= 1'b0;
		end else
			keyout <= 1'b1;
	end else
		keyout <= 1'b0;
end
	
endmodule